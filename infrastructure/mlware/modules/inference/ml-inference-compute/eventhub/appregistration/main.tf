locals {
  dapr_url = "app-reg-dapr-${var.short_code}-${var.app_env}-${var.region_code}"
}

resource "azuread_application" "app_reg_dapr" {
  display_name    = local.dapr_url
  identifier_uris = ["api://${local.dapr_url}"]
  owners          = concat(var.dapr_app_owners, [var.current_tenant_object_id])
  required_resource_access {
    // Scope Permissions
    resource_app_id = "00000003-0000-0000-c000-000000000000" // Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" // User.Read
      type = "Scope"
    }
    resource_access {
      id   = "0e263e50-5827-48a4-b97c-d940288653c7" // Directory.AccessAsUser.All
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "dapr_service_principal" {
  application_id = azuread_application.app_reg_dapr.application_id
}
resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.current_tenant_id
  object_id    = azuread_service_principal.dapr_service_principal.object_id

  key_permissions = [
    "Get", "List", "Update", "Create", "Recover"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Recover"
  ]
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Recover"
  ]


}
resource "azuread_application_password" "dapr_application_password" {
  application_object_id = azuread_application.app_reg_dapr.object_id
  display_name          = "app-reg-dapr-client-secret-${var.short_code}-${var.region_code}-${var.app_env}"
}

resource "azurerm_key_vault_secret" "client_secret_key_vault" {
  name         = "app-reg-dapr-client-secret-${var.short_code}-${var.region_code}-${var.app_env}"
  value        = azuread_application_password.dapr_application_password.value
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "client_id_key_vault" {
  name         = "app-reg-dapr-client-id-${var.short_code}-${var.region_code}-${var.app_env}"
  value        = azuread_application.app_reg_dapr.application_id
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}
resource "azurerm_role_assignment" "dapr_app_reg_eh_ra" {
  scope                = var.eventhub_namespace_id
  role_definition_name = "Azure Event Hubs Data Owner"
  principal_id         = azuread_service_principal.dapr_service_principal.object_id
}
resource "azurerm_role_assignment" "dapr_app_reg_st_ra" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.dapr_service_principal.object_id
}

