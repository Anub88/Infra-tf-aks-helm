locals {
  uai-name = "user-managed-identity-dapr-${var.short_code}-${var.app_env}-${var.region_code}"

}
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location            = var.location
  name                = local.uai-name
  resource_group_name = var.aks_managed_rg_name
  tags                = var.tags
}
resource "azurerm_key_vault_secret" "user_assigned_identity_client_key" {
  name         = "${local.uai-name}-clientid"
  value        = azurerm_user_assigned_identity.user_assigned_identity.client_id
  key_vault_id = var.key_vault_id
}

resource "azurerm_role_assignment" "event_hub_role_assignment" {
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  scope                = var.eventhub_namespace_id
  role_definition_name = "Azure Event Hubs Data Owner"
}