
resource "azurerm_api_management_product" "apim_product" {
  product_id            = var.product_name
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.product_name
  subscriptions_limit   = var.subscription_limit
  subscription_required = true
  approval_required     = true
  published             = true
}
resource "azurerm_api_management_product_api" "add_api_to_product" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["required"]
  }
  api_name            = each.key
  product_id          = azurerm_api_management_product.apim_product.product_id
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
}

