locals {
  apim_appreg_name = "appreg-apim-${var.app_env}-${var.name}"
}
resource "random_uuid" "app_registration_scope_id_default" {}
resource "random_uuid" "app_registration_scope_id_read" {}
resource "azuread_application" "app_reg_apim" {
  display_name    = local.apim_appreg_name
  owners          = var.apim_app_backend_owners
  identifier_uris = ["api://${local.apim_appreg_name}-${var.ml_workspace_short_code}"]
  sign_in_audience = "AzureADMultipleOrgs"
  required_resource_access {
    // Scope Permissions
    resource_app_id = "00000003-0000-0000-c000-000000000000" // Microsoft Graph
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" // User.Read
      type = "Scope"
    }
  }
  api {
    requested_access_token_version = 2
    oauth2_permission_scope {
      admin_consent_description = "default"
      admin_consent_display_name = "default"
      enabled                 = true
      id                      = random_uuid.app_registration_scope_id_default.id
      type                    = "User"
      value                   = "default"
    }
    oauth2_permission_scope {
      admin_consent_description= "Files.Read"
      admin_consent_display_name = "Files.Read"
      enabled                 = true
      id                      = random_uuid.app_registration_scope_id_read.id
      type                    = "User"
      value                   = "Files.Read"
    }

  }

  dynamic "required_resource_access" {
    for_each = toset(var.app_reg_clients)
    content {
      resource_app_id = required_resource_access.key
      resource_access {
        id   = "989b0ce6-d359-4820-4a62-047f4f762d7b"
        type = "Scope"
      }
    }
  }

}
resource "azuread_application_pre_authorized" "apim_application_pre_authorized" {
  count    = length(var.app_reg_clients)
  application_object_id = azuread_application.app_reg_apim.object_id
  authorized_app_id     = var.app_reg_clients[count.index]
  permission_ids        = [random_uuid.app_registration_scope_id_read.id]
}
resource "azuread_service_principal" "apim_service_principal" {
  application_id = azuread_application.app_reg_apim.application_id
}


resource "azuread_application_password" "apim_application_password" {
  application_object_id = azuread_application.app_reg_apim.object_id
  display_name          = "${local.apim_appreg_name}-client-secret"
}

resource "azurerm_key_vault_secret" "client_secret_key_vault" {
  name         = "${local.apim_appreg_name}-client-secret"
  value        = azuread_application_password.apim_application_password.value
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}


resource "azurerm_key_vault_secret" "client_id_key_vault" {
  name         = "${local.apim_appreg_name}-client-id"
  value        = azuread_application.app_reg_apim.application_id
  key_vault_id = var.key_vault_id
  content_type = "text/plain"
  tags         = var.tags
}
