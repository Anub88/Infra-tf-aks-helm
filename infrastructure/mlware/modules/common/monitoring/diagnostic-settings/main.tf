data "azurerm_monitor_diagnostic_categories" "diagnostic_setting_categories" {
  resource_id = var.resource_ids

}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = "diagnostic-logs-${var.app_env}"
  target_resource_id         = var.resource_ids
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.diagnostic_setting_categories.log_category_groups)

    content {
      category_group = log.value
      enabled  = true
    }
  }


  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.diagnostic_setting_categories.metrics)

    content {
      category = metric.value
      enabled  = true
    }
  }
}
