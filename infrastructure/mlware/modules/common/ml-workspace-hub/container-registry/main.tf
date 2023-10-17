resource "azurerm_container_registry" "acr" {
  name                          = "acr${var.ml_workspace_short_code}${var.app_env}${var.region_code}"
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  sku                           = var.acr_config.sku
  public_network_access_enabled = var.acr_config.public_network_access_enabled
  tags                          = var.tags
  trust_policy = [{
    enabled = var.acr_config.content_trust
  }]

  quarantine_policy_enabled = var.acr_config.quarantine_policy_enabled

  retention_policy {
    days    = 90
    enabled = true
  }
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "pvtcnt-${azurerm_container_registry.acr.name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
  private_service_connection {
    name                           = "svccnt-${azurerm_container_registry.acr.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names = [
      "registry"
    ]
  }
  tags = var.tags
}
