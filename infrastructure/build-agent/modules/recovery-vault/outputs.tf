output "recovery_vault_name" {
  value = azurerm_recovery_services_vault.recovery_vault.name
}

output "backup_policy_id" {
  value = azurerm_backup_policy_vm.backup_policy.id
}
