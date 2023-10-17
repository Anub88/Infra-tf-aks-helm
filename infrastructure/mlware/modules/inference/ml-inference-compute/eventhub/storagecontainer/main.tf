locals {
  network_watcher_default_resource_group = "NetworkWatcherRG"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "eventhubst${var.short_code}${var.app_env}${var.region_code}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.st_account_tier
  account_replication_type = var.st_account_replication_type
  identity {
    type = "SystemAssigned"
  }
  min_tls_version = "TLS1_2"
  tags            = var.tags
}
resource "azurerm_storage_container" "storage_container" {
  name                  = "eventhub-namespace-${var.short_code}-${var.app_env}-${var.region_code}-container"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
resource "azurerm_key_vault_secret" "storage_account_key" {
  name         = "eventhub-namespace-${var.short_code}-${var.app_env}-${var.region_code}-access-key"
  value        = azurerm_storage_account.storage_account.primary_access_key
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "storage_account_name" {
  name         = "eventhub-namespace-${var.short_code}-${var.app_env}-${var.region_code}-storage-name"
  value        = azurerm_storage_account.storage_account.name
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "storage_container_name" {
  name         = "eventhub-namespace-${var.short_code}-${var.app_env}-${var.region_code}-container-name"
  value        = azurerm_storage_container.storage_container.name
  key_vault_id = var.key_vault_id
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pvtcnt-${azurerm_storage_account.storage_account.name}-event-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags
  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.storage_private_dns_zone_id]
  }
  private_service_connection {
    name                           = "svccnt-${azurerm_storage_account.storage_account.name}-event-hub"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

##NSG 
resource "azurerm_network_security_group" "eventhub_storage_nsg" {
  name                = "nsg-eventhub-storage-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

##NSG association
resource "azurerm_subnet_network_security_group_association" "nsg_assocoation_eventhub_storage" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.eventhub_storage_nsg.id
}

## NSG Flow Log enable
resource "azurerm_network_watcher_flow_log" "eventhub_storage_flow_logs" {

  network_watcher_name      = var.network_watcher_name
  resource_group_name       = local.network_watcher_default_resource_group
  name                      = "eventhub-storageaccount-nsg-flowlog-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  network_security_group_id = azurerm_network_security_group.eventhub_storage_nsg.id
  storage_account_id        = var.module_aks_nsg_flowlog_storage_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = var.flow_log_retention_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_workspace_id
    workspace_region      = var.location
    workspace_resource_id = var.log_analytics_workspace_resource_id
    interval_in_minutes   = 10
  }
  tags = var.tags
}
