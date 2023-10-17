resource "random_uuid" "app_registration_scope_id_default" {}
resource "random_uuid" "app_registration_scope_id_read" {}

locals {
  apim_url = "apim-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
}

resource "azuread_application" "integration_test_application" {
  display_name    = "app-${var.ml_workspace_short_code}-${var.region_code}-${var.app_env}-integration-test"
  identifier_uris = ["api://app-${var.ml_workspace_short_code}-${var.region_code}-${var.app_env}-integration-test"]
  api {
    # This version is required for an oauth2 flow and to access API management. 
    requested_access_token_version = 2
    oauth2_permission_scope {
      admin_consent_description  = "The default admin consent"
      admin_consent_display_name = "default"
      enabled                    = true
      user_consent_description   = "The default user consent"
      user_consent_display_name  = "default"
      id                         = random_uuid.app_registration_scope_id_default.id
      type                       = "User"
      value                      = "default"
    }
    oauth2_permission_scope {
      admin_consent_description  = "The admin consent to read files"
      admin_consent_display_name = "Files.Read"
      enabled                    = true
      user_consent_description   = "The user consent to read files"
      user_consent_display_name  = "Files.Read"
      id                         = random_uuid.app_registration_scope_id_read.id
      type                       = "User"
      value                      = "files_read"
    }
  }
  web {
    redirect_uris = [
      "https://${local.apim_url}.portal.azure-api.net/docs/services/apimoauth/console/oauth2/authorization",
      "https://${local.apim_url}.developer.azure-api.net/signin-oauth/implicit/callback",
      "https://${local.apim_url}.developer.azure-api.net/signin-oauth/code/callback/apim_auth-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
    ]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
  owners = [
    var.current_tenant_object_id,
    "583f1f6c-d207-463b-8d6b-70c8bd3d36d7" # object ID for malou.ockenfels.ext@zeiss.com
  ]
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "integration_test_service_principal" {
  application_id = azuread_application.integration_test_application.application_id
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.current_tenant_id
  object_id    = azuread_service_principal.integration_test_service_principal.object_id

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

resource "azuread_application_password" "client_secret_integration_test" {
  application_object_id = azuread_application.integration_test_application.object_id
  display_name          = "integration-tests-client-secret-${var.ml_workspace_short_code}-${var.region_code}-${var.app_env}"
}

resource "azurerm_key_vault_secret" "client_secret_key_vault" {
  name            = "integration-tests-client-secret-${var.ml_workspace_short_code}-${var.region_code}-${var.app_env}"
  value           = azuread_application_password.client_secret_integration_test.value
  key_vault_id    = var.key_vault_id
  content_type    = "text/plain"
  expiration_date = var.key_vault_secret_expiration_date
  depends_on      = [azurerm_key_vault_access_policy.kv-policy]
}

resource "azurerm_key_vault_secret" "client_id_key_vault" {
  name            = "integration-tests-client-id-${var.ml_workspace_short_code}-${var.region_code}-${var.app_env}"
  value           = azuread_application.integration_test_application.application_id
  key_vault_id    = var.key_vault_id
  content_type    = "text/plain"
  expiration_date = var.key_vault_secret_expiration_date
  depends_on      = [azurerm_key_vault_access_policy.kv-policy]
}


resource "azurerm_role_assignment" "integration_test_app_ra" {
  scope                            = var.resource_group_id
  role_definition_name             = "Contributor"
  principal_id                     = azuread_service_principal.integration_test_service_principal.object_id
  skip_service_principal_aad_check = true

}

resource "azurerm_key_vault_secret" "integration_test_secret_key_vault" {
  name            = "integration-tests-key"
  value           = "some-test-value"
  key_vault_id    = var.key_vault_id
  content_type    = "text/plain"
  expiration_date = var.key_vault_secret_expiration_date
}
