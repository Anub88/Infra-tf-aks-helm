module "az_key_vault" {
  source                  = "./key-vault"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  vnet_id                 = var.vnet_id
  kv_config               = var.kv_config
  ml_workspace_short_code = var.ml_workspace_short_code
  ml_inf_short_code       = var.ml_inf_short_code
  app_env                 = var.app_env
  region_code             = var.region_code
  tags                    = var.tags
  private_dns_zone_id     = var.kv_private_dns_zone_id
  kv_subnet_id            = var.subnet_id
  action_group_id         = var.action_group_id
  kv_dynamic_alert_rules  = var.kv_dynamic_alert_rules
  kv_static_alert_rules   = var.kv_static_alert_rules
}
data "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name = "privatelink.azurecr.io"
}
module "acr" {
  source                  = "./container-registry"
  acr_config              = var.acr_config
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  ml_workspace_short_code = var.ml_workspace_short_code
  app_env                 = var.app_env
  region_code             = var.region_code
  vnet_id                 = var.vnet_id
  vnet_inf_id             = var.vnet_inf_id
  tags                    = var.tags
  subnet_id               = var.subnet_id
  private_dns_zone_id     = var.acr_private_dns_zone_id
}
module "load_testing" {
  source                  = "./load-testing"
  app_env                 = var.app_env
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
}

module "cosmo_mongodb" {
  source                           = "./cosmosdb"
  cosmodb_kind                     = var.cosmodb_kind
  cosmodb_offer_type               = var.cosmodb_offer_type
  environment                      = var.app_env
  ml_workspace_short_code          = var.ml_workspace_short_code
  region_code                      = var.region_code
  resource_group_location          = var.resource_group_location
  resource_group_name              = var.resource_group_name
  tags                             = var.tags
  cosmodb_subnet_id                = var.cosmodb_subnet_id
  capabilities                     = var.capabilities
  failover_priority                = var.failover_priority
  max_interval_in_seconds          = var.max_interval_in_seconds
  max_staleness_prefix             = var.max_staleness_prefix
  consistency_level                = var.consistency_level
  cosmos_private_dns_zone_name_id  = var.cosmos_private_dns_zone_name_id
  log_analytics_workspace_id       = var.log_analytics_workspace_id
  cosmosdb_sql_collections          = var.cosmosdb_sql_collections
  #cosmosdb_sql_database_name       = var.cosmosdb_sql_database_name
  cosmosdb_sql_database_throughput = var.cosmosdb_sql_database_throughput
  key_vault_id                     = module.az_key_vault.key_vault_id
}


