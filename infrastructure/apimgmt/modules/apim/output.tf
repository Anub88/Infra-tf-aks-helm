# Declare your outputs here
output "api_management_id" {
  description = "The id of the azure api management resource"
  value       = azurerm_api_management.apim.id
}
output "api_management_principal_id" {
  description = "The id of the azure AD principle associated to the api management resource"
  value       = azurerm_api_management.apim.identity[0].principal_id
}

output "api_management_name" {
  description = "The name of the api management"
  value       = azurerm_api_management.apim.name
}
