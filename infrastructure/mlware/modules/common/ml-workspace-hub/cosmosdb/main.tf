locals {
 cosmosdb_account_name = "aixs-cosmodb-${var.ml_workspace_short_code}-${var.environment}-${var.region_code}"
 cosmosdatabase_name = "aixs-cosmodb-mogodb-${var.ml_workspace_short_code}-${var.environment}-${var.region_code}"

}

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  location            = var.resource_group_location
  name                = local.cosmosdb_account_name
  offer_type          = var.cosmodb_offer_type
  resource_group_name = var.resource_group_name
  kind                = var.cosmodb_kind
  dynamic "capabilities" {
    for_each = var.capabilities != null ? var.capabilities : []
    content {
      name = capabilities.value
    }
  }
  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }
  geo_location {
    failover_priority = var.failover_priority
    location          = var.resource_group_location
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb_mongo_database" {
  name                = local.cosmosdatabase_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  throughput          = var.cosmosdb_sql_database_throughput
}

resource "azurerm_cosmosdb_mongo_collection" "cosmosdb_mongo_collection" {
  for_each = var.cosmosdb_sql_collections

  account_name           = azurerm_cosmosdb_account.cosmosdb_account.name
  database_name          = azurerm_cosmosdb_mongo_database.cosmosdb_mongo_database.name
  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  shard_key              = each.value.shard_key
  throughput             = each.value.throughput
  index {
    keys   = each.value.unique_keys
    unique = each.value.unique
  }

}



resource "azurerm_private_endpoint" "private_endpoint" {
  location            = var.resource_group_location
  name                = "${local.cosmosdb_account_name}-pe"
  resource_group_name = var.resource_group_name
  subnet_id           = var.cosmodb_subnet_id
  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.cosmos_private_dns_zone_name_id]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "${local.cosmosdb_account_name}-privatelink"
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb_account.id
    subresource_names              = [var.cosmodb_kind]
  }
  tags = var.tags
}
data "azurerm_monitor_diagnostic_categories" "ds_categories" {
  resource_id = azurerm_cosmosdb_account.cosmosdb_account.id
}
resource "azurerm_monitor_diagnostic_setting" "log_analytics" {
  name                       = "${local.cosmosdb_account_name}-analytics"
  target_resource_id         = azurerm_cosmosdb_account.cosmosdb_account.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.ds_categories.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = false
      }
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

## adding password to KV

resource "azurerm_key_vault_secret" "cosmosdb_rw_password" {
  name         = "cosmos-mongodb-rw-password"
  value        = azurerm_cosmosdb_account.cosmosdb_account.primary_key
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}