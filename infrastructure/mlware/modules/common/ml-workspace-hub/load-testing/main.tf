# Create a load test resource
resource "azurerm_load_test" "load_test" {
  location            = var.resource_group_location
  name                = "load-test-${var.app_env}"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}