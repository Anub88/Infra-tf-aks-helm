resource "azurerm_api_management_api" "apimapi" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["required"]
  }
  name                = each.key
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  revision            = "1"
  display_name        = each.key
  path                = each.value.backend == false ? "" : each.key
  service_url         = each.value.backend_url
  protocols           = ["https"]

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/${each.value.api_spec}")
  }

  oauth2_authorization {
    authorization_server_name = "apim_auth-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  }

}

resource "azurerm_api_management_backend" "apimbackend" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["backend"]
  }
  name                = each.key
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  protocol            = "http"
  url                 = "https://${each.key}.azurewebsites.net/api/"
  resource_id         = "https://${each.key}.azurewebsites.net"
  title               = each.key
  description         = each.key

  depends_on = [azurerm_api_management_named_value.apimnamedvalue]

  credentials {
    header = {
      x-functions-key = "{{${each.key}-key}}"
    }
  }
}

resource "azurerm_api_management_named_value" "apimnamedvalue" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["backend"]
  }
  name                = "${each.key}-key"
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  display_name        = "${each.key}-key"
  value               = "Dummy value" # should be replaced with actual function host key creadted specfically for apim
  secret              = true
  tags                = ["key", "function"]
}
