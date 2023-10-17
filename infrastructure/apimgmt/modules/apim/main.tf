
resource "azurerm_api_management" "apim" {
  name                = "apim-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_apim

  identity {
    type = "SystemAssigned"
  }

  virtual_network_type = "External"

  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [tags,]
  }
}

resource "azurerm_role_assignment" "apim_kv_access_role_assignment" {
  scope                = var.key_vault_id
  role_definition_name = "contributor"
  principal_id         = azurerm_api_management.apim.identity[0].principal_id
}

resource "azurerm_key_vault_access_policy" "kv_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.current_user_tenant_id
  object_id    = azurerm_api_management.apim.identity[0].principal_id
  key_permissions = [
    "Get", "List", "Update", "Create", "Recover"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge","Recover"
  ]
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Recover"
  ]


}
