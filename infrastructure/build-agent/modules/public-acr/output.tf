output "acr_name" {
  description = "The name of the azure container registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_id" {
  description = "The id of the azure container registry"
  value       = azurerm_container_registry.acr.id
}