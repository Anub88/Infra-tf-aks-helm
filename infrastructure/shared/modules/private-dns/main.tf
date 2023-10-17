
# create dns zone
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone
  resource_group_name = var.resource_group_name
  tags                = var.tags

}

# create vnet link to cicd vnet
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = "vlink-${var.buildagent_vnet_name}"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.buildagent_vnet_id
  tags                  = var.tags
}
