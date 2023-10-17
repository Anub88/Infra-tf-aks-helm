output "app_insights_conn_string" {
  value = azurerm_application_insights.monitoring_appinsight.connection_string
}
output "app_insights_key" {
  value = azurerm_application_insights.monitoring_appinsight.instrumentation_key
}

output "monitor_action_group_id" {
  value = azurerm_monitor_action_group.monitor_action_group.id
}
