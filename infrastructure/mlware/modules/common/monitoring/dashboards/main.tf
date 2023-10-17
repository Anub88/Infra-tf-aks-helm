
resource "azurerm_portal_dashboard" "aixs_dashboard" {
  name                          = "aixs-dashboard-${var.app_env}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags

  dashboard_properties = templatefile("${path.module}/dash.tpl",
    {
      region                      = var.region
      eventhub_id                 = var.eventhub_id
      eventhub_name               = var.eventhub_name
      kubernetes_id               = var.kubernetes_id
      kubernetes_name             = var.kubernetes_name
      log_analytics_workspace_id  = var.log_analytics_workspace_id
  })
}

