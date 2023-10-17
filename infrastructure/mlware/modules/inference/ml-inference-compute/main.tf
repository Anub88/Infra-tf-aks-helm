
module "aks" {
  source                               = "./aks"
  aks_node_pools                       = var.aks_node_pools
  aks_config                           = var.aks_config
  ml_inf_short_code                    = var.ml_inf_short_code
  app_env                              = var.app_env
  region_code                          = var.region_code
  vnet_id                              = var.vnet_id
  vnet_subnets_name_id                 = var.vnet_inf_subnets_name_id
  resource_group_name                  = var.resource_group_name
  resource_group_location              = var.resource_group_location
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  log_analytics_workspace_workspace_id = var.log_analytics_workspace_workspace_id
  acr_id                               = var.acr_id
  tags                                 = var.tags
  current_tenant_id                    = var.current_tenant_id
  dapr_config_settings                 = var.dapr_config_settings
  dapr_version                         = var.dapr_version
  dapr_update                          = var.dapr_update
  flow_log_retention_days              = var.flow_log_retention_days
  pod_max_pid                          = var.pod_max_pid
}

resource "azurerm_role_assignment" "aks_access_role_assignment" {
  scope                = var.resource_group_id
  role_definition_name = "Owner"
  principal_id         = module.aks.aks_principal_id
}

# Question: can't this move to the Network module?
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link_aks" {
  for_each              = var.aks_pvt_dns_vnet_id
  name                  = "vlink-${each.value.vnet_name}"
  private_dns_zone_name = module.aks.private_dns_zone_name
  resource_group_name   = module.aks.managed_rg_name
  virtual_network_id    = each.value.vnet_id
  tags                  = var.tags
}


module "eventhub" {
  source                               = "./eventhub"
  resource_group_name                  = var.resource_group_name
  app_env                              = var.app_env
  region_code                          = var.region_code
  eventhub_subnet_id                   = var.eventhub_subnet_id
  short_code                           = var.ml_inf_short_code
  location                             = var.location
  tags                                 = var.tags
  sku                                  = var.eventhub_sku
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  servicebus_zone_id                   = var.servicebus_zone_id
  key_vault_id                         = var.key_vault_id
  storage_private_dns_zone_id          = var.storage_private_dns_zone_id
  current_tenant_id                    = var.current_tenant_id
  current_tenant_object_id             = var.current_tenant_object_id
  resource_group_id                    = var.resource_group_id
  aks_managed_rg_name                  = module.aks.managed_rg_name
  enable_dapr_app_registration         = var.enable_dapr_app_registration
  enable_dapr_managed_identity         = var.enable_dapr_managed_identity
  dapr_app_owners                      = var.dapr_app_owners
  vnet_subnets_name_id                 = var.vnet_inf_subnets_name_id
  log_analytics_workspace_workspace_id = var.log_analytics_workspace_workspace_id
  flow_log_retention_days              = var.flow_log_retention_days
  ml_inf_short_code                    = var.ml_inf_short_code
  log_analytics_workspace_resource_id  = var.log_analytics_workspace_resource_id
  module_aks_nsg_flowlog_storage_id    = module.aks.nsg_flowlog_storage_id
  network_watcher_name                 = module.aks.network_watcher_name

}
module "redis_cache" {
  source                         = "./redis-cache"
  environment                    = var.app_env
  key_vault_id                   = var.key_vault_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  ml_inf_short_code              = var.ml_inf_short_code
  redis_cache_config             = var.redis_cache_config
  redis_private_dns_zone_name_id = var.redis_private_dns_zone_name_id
  redis_subnet_id                = var.redis_subnet_id
  region_code                    = var.region_code
  resource_group_location        = var.resource_group_location
  resource_group_name            = var.resource_group_name
  tags                           = var.tags
  redis_private_dns_zone_name    = var.redis_private_dns_zone_name
  virtual_network_id             = var.vnet_id
  redis_private_dns_zone_rg      = var.redis_private_dns_zone_rg
}