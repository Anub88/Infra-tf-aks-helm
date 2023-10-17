resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.app_env}-weus-blagt"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = false
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.kv_config.soft_delete_days
  purge_protection_enabled    = var.kv_config.purge_protection
  sku_name                    = var.kv_config.sku
  tags                        = var.common_tags
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify",
    "List",
    "Update",
    "Create",
    "Recover"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge","Recover"
  ]
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Recover"
  ]
}