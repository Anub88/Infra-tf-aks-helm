locals {
  app_name = "appreg-aixs-${var.usecase}-s2s-hdp-${var.app_env}-${var.region_code}"
}

resource "azuread_application" "appreg_aixs" {
  display_name    = local.app_name
  identifier_uris = ["api://${local.app_name}"]
  owners          = concat(var.appreg_aixs_app_owners, [var.current_tenant_object_id])
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

resource "azuread_service_principal" "aixs_service_principal" {
  application_id = azuread_application.appreg_aixs.application_id
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.current_tenant_id
  object_id    = azuread_service_principal.aixs_service_principal.object_id

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
resource "azuread_application_password" "appreg_aixs_application_password" {
  application_object_id = azuread_application.appreg_aixs.object_id
  display_name          = "appreg-aixs-${var.usecase}-s2s-hdp-client-secret-${var.app_env}-${var.region_code}"
}

resource "azurerm_key_vault_secret" "appreg_aixs-s2s-hdp_client_secret_key_vault" {
  name         = "appreg-aixs-${var.usecase}-s2s-hdp-client-secret-${var.app_env}-${var.region_code}"
  value        = azuread_application_password.appreg_aixs_application_password.value
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "appreg_aixs-s2s-hdp_client_id_key_vault" {
  name         = "appreg-aixs-${var.usecase}-s2s-hdp-client-id-${var.app_env}-${var.region_code}"
  value        = azuread_application.appreg_aixs.application_id
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}