locals {
  redis_account_name = "aixs-redis-cache-${var.ml_inf_short_code}-${var.environment}-${var.region_code}"
}


resource "azurerm_redis_cache" "redis_cache" {
  name                = local.redis_account_name
  resource_group_name = var.resource_group_name
  capacity            = var.redis_cache_config.capacity
  family              = var.redis_cache_config.family
  location            = var.resource_group_location
  sku_name            = var.redis_cache_config.sku_name
  enable_non_ssl_port = var.redis_cache_config.enable_non_ssl_port
  minimum_tls_version = var.redis_cache_config.minimum_tls_version
  shard_count         = var.redis_cache_config.sku_name == "Premium" ? var.redis_cache_config.shard_count : null
  redis_configuration {
    maxmemory_reserved = var.redis_cache_config.redis_configuration["maxmemory_reserved"]
    maxmemory_delta    = var.redis_cache_config.redis_configuration["maxmemory_delta"]
    maxmemory_policy   = var.redis_cache_config.redis_configuration["maxmemory_policy"]
  }

  tags = var.tags

}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${local.redis_account_name}-pe"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.redis_subnet_id
  tags                = var.tags

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.redis_private_dns_zone_name_id]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "${local.redis_account_name}-privatelink"
    private_connection_resource_id = azurerm_redis_cache.redis_cache.id
    subresource_names              = var.redis_cache_config.redis_subresource_names
  }
}

data "azurerm_private_endpoint_connection" "private-ip" {
  name                = azurerm_private_endpoint.private_endpoint.name
  resource_group_name = var.resource_group_name

}
resource "azurerm_private_dns_a_record" "private_dns_a_record" {
  name                = "${local.redis_account_name}-dns_a_record"
  zone_name           = var.redis_private_dns_zone_name
  resource_group_name = var.redis_private_dns_zone_rg
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.private-ip.private_service_connection.0.private_ip_address]
}

resource "azurerm_key_vault_secret" "redis_access-key_secret" {
  key_vault_id = var.key_vault_id
  name         = "${local.redis_account_name}-primary-access-key"
  value        = azurerm_redis_cache.redis_cache.primary_access_key
}
resource "azurerm_key_vault_secret" "redis_connection_string" {
  key_vault_id = var.key_vault_id
  name         = "${local.redis_account_name}-primary-connection-string"
  value        = azurerm_redis_cache.redis_cache.primary_connection_string
}
data "azurerm_monitor_diagnostic_categories" "ds_categories" {
  resource_id = azurerm_redis_cache.redis_cache.id
}
resource "azurerm_monitor_diagnostic_setting" "log_analytics" {
  name                       = "${local.redis_account_name}-analytics"
  target_resource_id         = azurerm_redis_cache.redis_cache.id
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