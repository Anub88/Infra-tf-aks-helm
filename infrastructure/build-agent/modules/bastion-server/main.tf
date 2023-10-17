resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion-${var.app_env}-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Default sku is basic added this line so that if required to be changed to standard we can add.
resource "azurerm_bastion_host" "bastion_creation" {
  name                = "bastion-${var.app_env}-${var.region_code}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
  tunneling_enabled   = true
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}
