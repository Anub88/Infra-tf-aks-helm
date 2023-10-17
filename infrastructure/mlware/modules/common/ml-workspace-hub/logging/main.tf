resource "azurerm_log_analytics_workspace" "logws" {
  name                = "lws-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.aks_lws_config.sku
  retention_in_days   = var.aks_lws_config.retention_in_days
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "log_analytics_solution_container_insights" {
  solution_name         = "ContainerInsights"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.logws.id
  workspace_name        = azurerm_log_analytics_workspace.logws.name
  tags                  = var.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_log_analytics_solution" "log_analytics_sentinel" {
  solution_name         = "SecurityInsights"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.logws.id
  workspace_name        = azurerm_log_analytics_workspace.logws.name
  tags                  = var.tags
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}
