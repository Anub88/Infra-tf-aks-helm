
resource "azurerm_virtual_network_peering" "peer_mlinf_mlws" {
  name                      = var.virtual_network_peering_name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.remote_virtual_network_id
  lifecycle {
    ignore_changes = [
      remote_virtual_network_id, name,
    ]
  }
}
