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
  rg_name = "rg-${var.proj_name}-${var.app_env}-${var.region_code}"
  common_tags = {
    ContactEmailAddress = "chand.basha@zeiss.com,abhinay.patel@zeiss.com"
    application         = "mlware-platform"
    department          = "dbu-ai"
    env                 = "${var.app_env}"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}


data "azurerm_virtual_network" "ba_vnet" {
  name                = var.buildagent_vnet_name
  resource_group_name = var.buildagent_rg_name
}

data "azurerm_resource_group" "ba_rg" {
  name = var.buildagent_rg_name
}

data "azurerm_resource_group" "shared_rg" {
  name = var.shared_resource_group_name
}
data "azurerm_private_dns_zone" "storage_private_dns_zone" {
  name = var.storage_private_dns_zone_name
}

module "networking" {
  source                     = "./modules/common/networking"
  ml_inf_short_code          = var.ml_inf_short_code
  ml_api_short_code          = var.ml_api_short_code
  ml_workflow_short_code     = var.ml_workflow_short_code
  ml_workspace_short_code    = var.ml_workspace_short_code
  ml_ingestion_short_code    = var.ml_ingestion_short_code
  region_code                = var.region_code
  app_env                    = var.app_env
  cidr_space                 = var.cidr_space
  cidr_mlinf                 = var.cidr_mlinf
  resource_group_name        = azurerm_resource_group.rg.name
  resource_group_location    = azurerm_resource_group.rg.location
  shared_resource_group_name = data.azurerm_resource_group.shared_rg.name
  buildagent_rg_name         = data.azurerm_resource_group.ba_rg.name
  buildagent_vnet_name       = data.azurerm_virtual_network.ba_vnet.name
  buildagent_vnet_id         = data.azurerm_virtual_network.ba_vnet.id
  dns_names                  = var.dns_names
  tags                       = local.common_tags
  vnet_location              = var.location
}

module "logging" {
  source                  = "./modules/common/ml-workspace-hub/logging"
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  aks_lws_config          = var.aks_lws_config
  ml_inf_short_code       = var.ml_inf_short_code
  app_env                 = var.app_env
  region_code             = var.region_code
  tags                    = local.common_tags
}

data "azurerm_private_dns_zone" "kv_private_dns_zone" {
  name = var.kv_private_dns_zone_name
}
data "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name = var.acr_private_dns_zone_name
}
data "azurerm_private_dns_zone" "sevicebus_private_dns_zone" {
  name = var.servicebus_private_dns_zone_name
}
data "azurerm_private_dns_zone" "cosmos_private_dns_zone_name" {
  name = var.cosmos_private_dns_zone_name
}
data "azurerm_private_dns_zone" "redis_private_dns_zone_name" {
  name = var.redis_private_dns_zone_name
}
module "ml_workspace_hub" {
  source                           = "./modules/common/ml-workspace-hub"
  acr_config                       = var.acr_config
  kv_config                        = var.kv_config
  aks_lws_config                   = var.aks_lws_config
  vm_config                        = var.vm_config
  subnet_id                        = module.networking.cloud_service_subnet_id
  vnet_id                          = module.networking.vnet_id
  vnet_inf_id                      = module.networking.vnet_inf_id
  vnet_subnets_name_id             = module.networking.vnet_subnets_name_id
  resource_group_name              = azurerm_resource_group.rg.name
  resource_group_location          = azurerm_resource_group.rg.location
  ml_workspace_short_code          = var.ml_workspace_short_code
  ml_inf_short_code                = var.ml_inf_short_code
  app_env                          = var.app_env
  region_code                      = var.region_code
  tags                             = local.common_tags
  kv_private_dns_zone_id           = data.azurerm_private_dns_zone.kv_private_dns_zone.id
  acr_private_dns_zone_id          = data.azurerm_private_dns_zone.acr_private_dns_zone.id
  action_group_id                  = module.monitoring_app_insights.monitor_action_group_id
  kv_dynamic_alert_rules           = var.kv_dynamic_alert_rules
  kv_static_alert_rules            = var.kv_static_alert_rules
  cosmodb_kind                     = var.cosmodb_kind
  cosmodb_offer_type               = var.cosmodb_offer_type
  cosmodb_subnet_id                = module.networking.cosmodb_subnet_id
  capabilities                     = var.capabilities
  failover_priority                = var.failover_priority
  max_interval_in_seconds          = var.max_interval_in_seconds
  max_staleness_prefix             = var.max_staleness_prefix
  consistency_level                = var.consistency_level
  cosmos_private_dns_zone_name_id  = data.azurerm_private_dns_zone.cosmos_private_dns_zone_name.id
  log_analytics_workspace_id       = module.logging.azurerm_log_analytics_workspace_id
  cosmosdb_sql_collections          = var.cosmosdb_sql_collections
  #cosmosdb_sql_database_name       = var.cosmosdb_sql_database_name
  cosmosdb_sql_database_throughput = var.cosmosdb_sql_database_throughput

}
data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

module "ml_inference_compute" {
  source                               = "./modules/inference/ml-inference-compute"
  aks_node_pools                       = var.aks_node_pools
  aks_config                           = var.aks_config
  ml_inf_short_code                    = var.ml_inf_short_code
  app_env                              = var.app_env
  region_code                          = var.region_code
  vnet_inf_subnets_name_id             = module.networking.vnet_inf_subnets_name_id
  vnet_id                              = module.networking.vnet_id
  resource_group_name                  = azurerm_resource_group.rg.name
  resource_group_id                    = azurerm_resource_group.rg.id
  resource_group_location              = azurerm_resource_group.rg.location
  log_analytics_workspace_id           = module.logging.azurerm_log_analytics_workspace_id
  log_analytics_workspace_resource_id  = module.logging.azurerm_log_analytics_workspace_id
  log_analytics_workspace_workspace_id = module.logging.azurerm_log_analytics_workspace_workspaceid
  acr_id                               = module.ml_workspace_hub.acr_id
  location                             = var.location
  aks_pvt_dns_vnet_id = { "vnet_ws" = {
    vnet_name = module.networking.vnet_name_ws
    vnet_id   = module.networking.vnet_name_ws_id
    }
    "vnet_ba" = {
      vnet_name = data.azurerm_virtual_network.ba_vnet.name
      vnet_id   = data.azurerm_virtual_network.ba_vnet.id
    }
  }

  tags                           = local.common_tags
  current_tenant_id              = data.azuread_client_config.current.tenant_id
  dapr_config_settings           = var.dapr_config_settings
  dapr_version                   = var.dapr_version
  dapr_update                    = var.dapr_update
  flow_log_retention_days        = var.flow_log_retention_days
  eventhub_sku                   = "Standard"
  eventhub_subnet_id             = module.networking.message_broker_subnet_id
  servicebus_zone_id             = data.azurerm_private_dns_zone.sevicebus_private_dns_zone.id
  key_vault_id                   = module.ml_workspace_hub.key_vault_id
  storage_private_dns_zone_id    = data.azurerm_private_dns_zone.storage_private_dns_zone.id
  current_tenant_object_id       = data.azuread_client_config.current.object_id
  enable_dapr_app_registration   = var.enable_dapr_app_registration
  enable_dapr_managed_identity   = var.enable_dapr_managed_identity
  dapr_app_owners                = var.dapr_app_owners
  pod_max_pid                    = var.pod_max_pid
  redis_cache_config             = var.redis_cache_config
  redis_private_dns_zone_name_id = data.azurerm_private_dns_zone.redis_private_dns_zone_name.id
  redis_subnet_id                = module.networking.redis_subnet_id
  redis_private_dns_zone_name    = var.redis_private_dns_zone_name
  redis_private_dns_zone_rg      = data.azurerm_private_dns_zone.redis_private_dns_zone_name.resource_group_name
}

# Authentication sometimes needs to be commented out because the service principal
# don't have the rights to create an app.
# This needs to be created manually if that's the case. Please add the service principle ID
# to the wiki page after the creation.
module "authentication" {
  source                           = "./modules/common/authentication"
  resource_group_id                = azurerm_resource_group.rg.id
  current_tenant_object_id         = data.azuread_client_config.current.object_id
  current_tenant_id                = data.azuread_client_config.current.tenant_id
  ml_workspace_short_code          = var.ml_workspace_short_code
  app_env                          = var.app_env
  region_code                      = var.region_code
  key_vault_id                     = module.ml_workspace_hub.key_vault_id
  key_vault_secret_expiration_date = var.key_vault_secret_expiration_date
}

module "monitoring_app_insights" {
  source                                      = "./modules/common/monitoring"
  resource_group_name                         = azurerm_resource_group.rg.name
  app_env                                     = var.app_env
  region_code                                 = var.region_code
  location                                    = var.location
  log_analytics_workspace_id                  = module.logging.azurerm_log_analytics_workspace_id
  tags                                        = local.common_tags
  email_address                               = var.email_address
  enabled_defender_plans                      = var.enabled_defender_plans
  security_center_contact_mail                = var.security_center_contact_mail
  compatibility_level                         = var.compatibility_level
  data_locale                                 = var.data_locale
  eventhub_default_primary_key                = module.ml_inference_compute.eventhub_default_primary_key
  eventhub_storage_account_primary_access_key = module.ml_inference_compute.eventhub_storage_account_primary_access_key
  eventhub_namespace_name                     = module.ml_inference_compute.eventhub_namespace_name
  eventhub_storage_account_name               = module.ml_inference_compute.eventhub_storage_account_name
  eventhub_names                              = var.eventhub_names
  events_late_arrival_max_delay_in_seconds    = var.events_late_arrival_max_delay_in_seconds
  events_out_of_order_max_delay_in_seconds    = var.events_out_of_order_max_delay_in_seconds
  events_out_of_order_policy                  = var.events_out_of_order_policy
  output_error_policy                         = var.output_error_policy
  start_mode                                  = var.start_mode
  streaming_units                             = var.streaming_units
  ml_inf_short_code                           = var.ml_inf_short_code
  shared_access_policy_name                   = var.shared_access_policy_name
}

## module.ml_workflow_engine.func_app_ids[0], module.ml_workflow_engine.func_app_ids[1] removed from for_each,
## modules itself not present any more even in develop branch?
module "diagnostics_settings" {
  source = "./modules/common/monitoring/diagnostic-settings"
  for_each = toset([module.ml_workspace_hub.acr_id,
  module.ml_workspace_hub.key_vault_id])
  resource_ids               = each.key
  log_analytics_workspace_id = module.logging.azurerm_log_analytics_workspace_id
  app_env                    = var.app_env
}


module "dashboards" {
  source                     = "./modules/common/monitoring/dashboards"
  resource_group_name        = azurerm_resource_group.rg.name
  app_env                    = var.app_env
  tags                       = local.common_tags
  location                   = var.location
  region                     = var.region
  eventhub_id                = module.ml_inference_compute.eventhub_namespace_id
  eventhub_name              = module.ml_inference_compute.eventhub_namespace_name
  kubernetes_id              = module.ml_inference_compute.aks_id
  kubernetes_name            = module.ml_inference_compute.aks_name
  log_analytics_workspace_id = module.logging.azurerm_log_analytics_workspace_id
}
