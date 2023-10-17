

resource "azurerm_api_management_authorization_server" "apim_auth" {
  name                         = "apim_auth-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  api_management_name          = var.api_management_name
  resource_group_name          = var.resource_group_name
  display_name                 = "apim_auth-${var.app_env}"
  authorization_endpoint       = var.authorization_endpoint
  client_id                    = var.client_id
  client_registration_endpoint = "http://localhost/client/register"
  client_secret                = var.client_secret
  client_authentication_method = ["Body"]
  default_scope                = "api://${var.client_id}/.default"
  bearer_token_sending_methods = ["authorizationHeader"]
  token_endpoint               = var.token_endpoint
  grant_types = [
    "clientCredentials"
  ]
  authorization_methods = [
    "GET", "POST"
  ]
}
