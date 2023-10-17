
resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = "AIXSalt${var.app_env}"
  resource_group_name = var.resource_group_name
  short_name          = "AIXSalt${var.app_env}"
  enabled             = var.enable_alert
  email_receiver {
    name                    = "AIXSDevops"
    email_address           = var.email_address
    use_common_alert_schema = true
  }
  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "vm_diagnosting_logs" {
  count              = length(var.virtual_machine_ids)
  name               = "diagnostic_log_${var.virtual_machine_names[count.index]}"
  target_resource_id = var.virtual_machine_ids[count.index]
  log_analytics_workspace_id = var.log_analytics_workspace_id
  metric {
    category = var.vm_metric_log.category
    enabled  = var.vm_metric_log.enabled
    retention_policy {
      enabled = var.vm_metric_log.retention_policy_enabled
      days    = var.vm_metric_log.retention_policy_days
    }
  }
}
resource "azurerm_monitor_metric_alert" "metric_alert" {
  count               = length(var.vm_monitor_metric_alerts)
  name                = var.vm_monitor_metric_alerts[count.index].name
  resource_group_name = var.resource_group_name
  description         = var.vm_monitor_metric_alerts[count.index].description
  severity            = var.vm_monitor_metric_alerts[count.index].severity
  scopes              = var.virtual_machine_ids
  frequency           = var.vm_monitor_metric_alerts[count.index].frequency
  window_size         = var.vm_monitor_metric_alerts[count.index].window_size
  criteria {
    aggregation      = var.vm_monitor_metric_alerts[count.index].aggregation
    metric_name      = var.vm_monitor_metric_alerts[count.index].metric_name
    metric_namespace = var.vm_monitor_metric_alerts[count.index].metric_namespace
    operator         = var.vm_monitor_metric_alerts[count.index].operator
    threshold        = var.vm_monitor_metric_alerts[count.index].threshold

  }
  action {
    action_group_id = azurerm_monitor_action_group.monitor_action_group.id
  }
}