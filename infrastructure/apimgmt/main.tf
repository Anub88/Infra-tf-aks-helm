provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.6.0"
    }
  }
}

locals {
  common_tags = {
    ContactEmailAddress = "chand.basha@zeiss.com,abhinay.patel@zeiss.com"
    application         = "CZMED-AIXS"
    department          = "dbu-ai"
    env                 = "${var.app_env}"
  }
}

data "azurerm_client_config" "current_user" {}
data "azuread_client_config" "current" {}
# Query subnet from MLWare state.
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_inf_name
}

data "azurerm_network_watcher" "network_watcher"{
name                = "NetworkWatcher_westus2"
resource_group_name = "NetworkWatcherRG"
}

data "azurerm_storage_account" "nsg_flowlog_storage" {
  name                = "stflowlog${var.ml_inference_short_code}${var.app_env}${var.region_code}"
  resource_group_name = var.resource_group_name
}

# Query key-vault from MLWare state.
data "azurerm_key_vault" "data_kv" {
  name                = "kv-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = var.resource_group_name
}

module "apim" {
  source              = "./modules/apim"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = local.common_tags
  ml_api_short_code   = var.ml_api_short_code
  app_env             = var.app_env
  region_code         = var.region_code
  key_vault_id           = data.azurerm_key_vault.data_kv.id
  current_user_tenant_id = data.azurerm_client_config.current_user.tenant_id
}

# Query key-vault secrets from MLWare state.
data "azurerm_key_vault_secret" "kv_secrets" {
  for_each     = toset(var.secret_key_names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.data_kv.id
}
module "oauth" {
  source                 = "./modules/oauth"
  resource_group_name    = var.resource_group_name
  authorization_endpoint = var.authorization_endpoint
  token_endpoint         = var.token_endpoint
  ml_api_short_code      = var.ml_api_short_code
  app_env                = var.app_env
  region_code            = var.region_code
  api_management_name    = module.apim.api_management_name
  client_id              = data.azurerm_key_vault_secret.kv_secrets["apim-auth-client-id"].value
  client_secret          = data.azurerm_key_vault_secret.kv_secrets["apim-auth-client-secret"].value
}

module "function_import" {
  source              = "./modules/function_import"
  resource_group_name = var.resource_group_name
  ml_api_short_code   = var.ml_api_short_code
  app_env             = var.app_env
  region_code         = var.region_code
  func_names_list     = var.func_names_list
  api_management_name = module.apim.api_management_name
}

module "product" {
  source              = "./modules/product"
  resource_group_name = var.resource_group_name
  location            = var.location
  func_names_list     = var.func_names_list
  product_name        = var.product_name
  subscription_limit  = var.subscription_limit
  api_management_name = module.apim.api_management_name
}

module "policies" {
  source              = "./modules/policies"
  resource_group_name = var.resource_group_name
  func_names_list     = var.func_names_list
  openid_config_url   = var.openid_config_url
  auth_client1        = var.auth_client1
  auth_client2        = var.auth_client2
  api_management_id   = module.apim.api_management_id
  api_management_name = module.apim.api_management_name
  quota_by_key_policy      = var.quota_by_key_policy
  rate_limit_by_key_policy = var.rate_limit_by_key_policy
}

# Query certificate from MLWare state.
data "azurerm_key_vault_certificate" "data_kv_certificate" {
  name         = "${var.app_env}-customdomain"
  key_vault_id = data.azurerm_key_vault.data_kv.id
}

module "customdns" {
  source                 = "./modules/customdns"
  app_env                = var.app_env
  apimgmnt_id            = module.apim.api_management_id
  kv_certificate_id      = data.azurerm_key_vault_certificate.data_kv_certificate.secret_id
}

# This application insights resource is created in the mlware state file.
data "azurerm_application_insights" "apimappinsight" {
  name                = "ins-${var.app_env}-${var.region_code}"
  resource_group_name = var.resource_group_name
}

module "logging" {
  source                           = "./modules/logging"
  resource_group_name              = var.resource_group_name
  ml_api_short_code                = var.ml_api_short_code
  app_env                          = var.app_env
  region_code                      = var.region_code
  func_names_list                  = var.func_names_list
  ml_inference_short_code          = var.ml_inference_short_code
  log_analytics_workspace_id       = data.azurerm_application_insights.apimappinsight.workspace_id
  api_management_id                = module.apim.api_management_id
  app_insights_name                = data.azurerm_application_insights.apimappinsight.name
  api_management_name              = module.apim.api_management_name
  app_insights_id                  = data.azurerm_application_insights.apimappinsight.id
  app_insights_instrumentation_key = data.azurerm_application_insights.apimappinsight.instrumentation_key
}

resource "azurerm_network_security_group" "apim_nsg" {
  name                = "nsg-apim-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.common_tags
}

#NSG rules not defined, as these rules will be implied from the policy

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.apim_nsg.id
}

resource "azurerm_network_security_rule" "nsg_rule_management_endpoint" {
  for_each = {
    for key, value in var.nsg_rules : key => value
  }
  name                        = "nsg-apim-${each.key}"
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.apim_nsg.name
}

data "azurerm_log_analytics_workspace" "log_analytics_ws"{
  name = "lws-${var.ml_inference_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = var.resource_group_name
}


resource "azurerm_network_watcher_flow_log" "apim_nsg_flow_logs" {

  network_watcher_name      = data.azurerm_network_watcher.network_watcher.name
  resource_group_name       = data.azurerm_network_watcher.network_watcher.resource_group_name
  name                      = "apim-nsg-flowlog-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  network_security_group_id = azurerm_network_security_group.apim_nsg.id
  storage_account_id        = data.azurerm_storage_account.nsg_flowlog_storage.id
  enabled                   = true
  location                  = var.location
  retention_policy {
    enabled = true
    days    = var.flow_log_retention_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.log_analytics_ws.workspace_id
    workspace_region      = var.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.log_analytics_ws.id
    interval_in_minutes   = 10
  }
  #tags = local.common_tags
}


module "apim_appregistration" {
  source = "./modules/appregistration"
  apim_app_backend_owners = var.apim_app_backend_owners
  apim_app_client_owners  = var.apim_app_client_owners
  apim_app_name           = module.apim.api_management_name
  app_env                 = var.app_env
  app_reg_backend_name    = var.app_reg_apim_backend_name
  app_reg_client_names    = var.app_reg_apim_client_names
  current_tenant_id       = data.azuread_client_config.current.tenant_id
  current_object_id       = data.azurerm_client_config.current_user.object_id
  key_vault_id            = data.azurerm_key_vault.data_kv.id
  ml_workspace_short_code = var.ml_workspace_short_code
  region_code             = var.region_code
  tags                    = local.common_tags
}

