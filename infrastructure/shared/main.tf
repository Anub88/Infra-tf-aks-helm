# Configure the Azure Provider
provider "azurerm" {
  # skip_provider_registration = true
  features {}
}

terraform {
  backend "azurerm" {}
  # Set the terraform required version
  required_version = ">= 1.0.0"
  # Register common providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.38.0"
    }
  }
}

locals {
  common_tags = {
    ContactEmailAddress = "chand.basha@zeiss.com,abhinay.patel@zeiss.com"
    application         = "mlware-platform"
    department          = "dbu-ai"
    env                 = "${var.app_env}"
  }
}

# Query current user.
data "azurerm_client_config" "current_user" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = local.common_tags
}

# Query build agent VNET.
data "azurerm_virtual_network" "ba_vnet" {
  name                = var.buildagent_vnet_name
  resource_group_name = var.buildagent_resource_group
}

module "private_dns" {
  source               = "./modules/private-dns"
  for_each             = toset(var.dns_names)
  private_dns_zone     = each.key
  resource_group_name  = var.resource_group_name
  buildagent_vnet_name = var.buildagent_vnet_name
  tags                 = local.common_tags
  buildagent_vnet_id   = data.azurerm_virtual_network.ba_vnet.id
}

# Query build agent key vault.
data "azurerm_key_vault" "kv" {
  name                = var.lg_vuln_not_kv_name
  resource_group_name = var.lg_vuln_not_kv_rg
}

module "vuln_notification_logic_app" {
  source                        = "./modules/logic-apps/vulnerability-notifications"
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.resource_group_location
  logic_app_name                = var.lg_vuln_not_name
  keyvault_connection           = var.lg_vuln_not_kv_conn
  office_365_connection         = var.lg_vuln_not_office_conn
  keyvault_api_name             = var.lg_vuln_not_kv_api_name
  office_api_name               = var.lg_vuln_not_office_api_name
  app_registration_name         = var.lg_vuln_not_app_reg_name
  keyvault_name                 = var.lg_vuln_not_kv_name
  keyvault_resource_group       = var.lg_vuln_not_kv_rg
  logic_app_deployment_name     = var.lg_vuln_not_logicapp_deployment_name
  office_conn_deployment_name   = var.lg_vuln_not_office_deployment_name
  keyvault_conn_deployment_name = var.lg_vuln_not_kv_deployment_name
  tenant_id                     = data.azurerm_client_config.current_user.tenant_id
  key_vault_id                  = data.azurerm_key_vault.kv.id
  app_env                       = var.app_env
}

module "la_cld_defender_alert_msteams" {
  source                        = "./modules/logic-apps/cloud-defender-alerts"
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.resource_group_location
  logic_app_name                = var.lg_cld_alert_name
  teams_connection              = var.lg_cld_alert_msteams_conn
  ascalert_connection           = var.lg_cld_alert_asc_conn
  teams_api_name                = var.lg_cld_alert_teams_api_name
  ascalert_api_name             = var.lg_cld_alert_asc_api_name
  logic_app_deployment_name     = var.lg_cld_alert_logicapp_deployment_name
  msteams_conn_deployment_name  = var.lg_cld_alert_msteams_deployment_name
  ascalert_conn_deployment_name = var.lg_cld_alert_asc_deployment_name
  app_env                       = var.app_env
}

