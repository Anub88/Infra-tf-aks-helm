output "azurerm_log_analytics_workspace_id" {
  description = "The id of the log analytics workspace created"
  value       = azurerm_log_analytics_workspace.logws.id
}
output "azurerm_log_analytics_workspace_workspaceid" {
  description = "The workspace id of the log analytics workspace created"
  value       = azurerm_log_analytics_workspace.logws.workspace_id
}
