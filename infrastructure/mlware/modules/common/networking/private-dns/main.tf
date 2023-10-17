data "azurerm_private_dns_zone" "private_dns_zone" {
  name = var.private_dns_zone
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  for_each              = var.vnet_ids
  name                  = "vlink-${each.value.vnet_name}"
  private_dns_zone_name = data.azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = var.dns_resource_group_name
  virtual_network_id    = each.value.vnet_id
  tags                  = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


