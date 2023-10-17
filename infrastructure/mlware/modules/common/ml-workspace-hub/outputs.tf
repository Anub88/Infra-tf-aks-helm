# Define outputs for module
output "key_vault_id" {
  description = "The id of the newly created keyvault"
  value       = module.az_key_vault.key_vault_id
}

output "key_vault_ref" {
  description = "The reference to the newly created keyvault"
  value       = module.az_key_vault.key_vault_ref
}

output "acr_name" {
  description = "The name of the azure container registry"
  value       = module.acr.acr_name
}

output "acr_id" {
  description = "The id of the azure container registry"
  value       = module.acr.acr_id
}