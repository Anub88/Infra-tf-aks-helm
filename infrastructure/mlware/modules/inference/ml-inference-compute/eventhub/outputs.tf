output "eventhub_namespace_id" {
  description = "event hub namespace id"
  value       = azurerm_eventhub_namespace.eventhub.id
}

output "eventhub_namespace_name" {
  description = "event hub namespace name"
  value       = azurerm_eventhub_namespace.eventhub.name
}
output "eventhub_storage_account_name" {
  value       = module.eventhubstoragecontainer.storage_account_name
}
output "eventhub_storage_account_primary_access_key" {
  value = module.eventhubstoragecontainer.storage_account_primary_access_key
}
output "eventhub_default_primary_key" {
  value = azurerm_eventhub_namespace.eventhub.default_primary_key
}