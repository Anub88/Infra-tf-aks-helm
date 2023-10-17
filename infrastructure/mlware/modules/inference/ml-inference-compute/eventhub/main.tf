resource "azurerm_eventhub_namespace" "eventhub" {
  name                = "eventhub-namespace-${var.short_code}-${var.app_env}-${var.region_code}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  identity {
    type = "SystemAssigned"
  }
  tags     = var.tags
  capacity = "2"
}



resource "azurerm_private_endpoint" "eventhub_private_endpoint" {
  name                = "pvtcnt-${azurerm_eventhub_namespace.eventhub.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.eventhub_subnet_id
  tags                = var.tags

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.servicebus_zone_id]
  }

  private_service_connection {
    name                           = "svccnt-${azurerm_eventhub_namespace.eventhub.name}"
    private_connection_resource_id = azurerm_eventhub_namespace.eventhub.id
    is_manual_connection           = false
    subresource_names = [
      "namespace"
    ]
  }
}

# Setup diagnostic settings.
data "azurerm_monitor_diagnostic_categories" "ds_eventhub_namespace_categories" {
  resource_id = azurerm_eventhub_namespace.eventhub.id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting_eventhub" {
  name                       = "diagnostic-logs"
  target_resource_id         = azurerm_eventhub_namespace.eventhub.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_eventhub_namespace_categories.log_category_types)

    content {
      category = log.value
      enabled  = true
    }
  }


  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_eventhub_namespace_categories.metrics)

    content {
      category = metric.value
      enabled  = true
    }
  }
}
module "eventhubstoragecontainer" {
  source                               = "./storagecontainer"
  app_env                              = var.app_env
  key_vault_id                         = var.key_vault_id
  location                             = var.location
  region_code                          = var.region_code
  resource_group_name                  = var.resource_group_name
  short_code                           = var.short_code
  storage_private_dns_zone_id          = var.storage_private_dns_zone_id
  subnet_id                            = var.eventhub_subnet_id
  tags                                 = var.tags
  ml_inf_short_code                    = var.ml_inf_short_code
  log_analytics_workspace_workspace_id = var.log_analytics_workspace_workspace_id
  log_analytics_workspace_resource_id  = var.log_analytics_workspace_resource_id
  flow_log_retention_days              = var.flow_log_retention_days
  module_aks_nsg_flowlog_storage_id    = var.module_aks_nsg_flowlog_storage_id
  network_watcher_name                 = var.network_watcher_name        
}

module "appregistration" {
  count                    = var.enable_dapr_app_registration ? 1 : 0
  source                   = "./appregistration"
  app_env                  = var.app_env
  current_tenant_id        = var.current_tenant_id
  current_tenant_object_id = var.current_tenant_object_id
  key_vault_id             = var.key_vault_id
  region_code              = var.region_code
  short_code               = var.short_code
  tags                     = var.tags
  eventhub_namespace_id    = azurerm_eventhub_namespace.eventhub.id
  storage_account_id       = module.eventhubstoragecontainer.storage_account_id
  dapr_app_owners          = var.dapr_app_owners
}

module "useridentity" {
  count                 = var.enable_dapr_managed_identity ? 1 : 0
  source                = "./useridentity"
  aks_managed_rg_name   = var.aks_managed_rg_name
  app_env               = var.app_env
  key_vault_id          = var.key_vault_id
  location              = var.location
  region_code           = var.region_code
  short_code            = var.short_code
  tags                  = var.tags
  eventhub_namespace_id = azurerm_eventhub_namespace.eventhub.id
}