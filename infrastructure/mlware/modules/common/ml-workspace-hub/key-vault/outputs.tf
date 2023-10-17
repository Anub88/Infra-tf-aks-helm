output "key_vault_id" {
  description = "The id of the newly created keyvault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_ref" {
  description = "The reference to the newly created keyvault"
  value       = azurerm_key_vault.kv
}
