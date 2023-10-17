locals {
  acr_name = "acrpub${var.ml_workspace_short_code}${var.app_env}${var.region_code}"
}
resource "azurerm_container_registry" "acr" {
  name                          = local.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  sku                           = var.acr_config.sku
  public_network_access_enabled = true
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

# Token-based access
# Create scope map
resource "azurerm_container_registry_scope_map" "acr_scope_map" {
  for_each                = toset(var.acr_repositories)
  name                    = replace("acr-scope-map-${each.value}", "_", "-")
  container_registry_name = local.acr_name
  resource_group_name     = var.resource_group_name
  actions = [
    "repositories/${each.value}/content/read",
    "repositories/${each.value}/content/write",
    "repositories/${each.value}/metadata/read",
    "repositories/${each.value}/metadata/write"
  ]
}
locals {
  scope_ids   = values(azurerm_container_registry_scope_map.acr_scope_map)[*].id
  scope_names = values(azurerm_container_registry_scope_map.acr_scope_map)[*].name
}
# Create token
resource "azurerm_container_registry_token" "acr_token" {
  count                   = length(local.scope_ids)
  name                    = "acr-token-${local.scope_names[count.index]}"
  container_registry_name = local.acr_name
  resource_group_name     = var.resource_group_name
  scope_map_id            = local.scope_ids[count.index]
}

# Using data to retrieve the logs and metrics manual available for the service. 
# This is required as there's no other way found to fetch DS manual.
# log_category_types is incompatible with current provider version so reverting back to logs until providers is upgraded.
data "azurerm_monitor_diagnostic_categories" "ds_categories" {
  resource_id = "${azurerm_container_registry.acr.id}"
}

resource "azurerm_monitor_diagnostic_setting" "acr_ds" {
  name                       = "diagnostic-logs-${var.ml_workspace_short_code}-${var.app_env}"
  target_resource_id         = "${azurerm_container_registry.acr.id}"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  
  dynamic "log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_categories.logs)

    content {
      category = log.value
      enabled  = true
    }
  }


  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_categories.metrics)

    content {
      category = metric.value
      enabled  = true
    }
  }
}