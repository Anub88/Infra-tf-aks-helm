locals {
  env = var.app_env == "shared-stage"? "stage_" : ""
  logic_app_workflow_arm_template  = file("${path.module}/arms/${local.env}la_workflow_config.json")
  msteams_connection_arm_template  = file("${path.module}/arms/${local.env}msteams_connection.json")
  ascalert_connection_arm_template = file("${path.module}/arms/${local.env}ascalert_connection.json")
}


resource "azurerm_logic_app_workflow" "logicapp" {
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  name                = var.logic_app_name

  lifecycle {
    ignore_changes = [
      # Ignore changes to parameters as otherwise we will break the $connections
      parameters,
      workflow_parameters,
      tags
    ]
  }
}

resource "azurerm_resource_group_template_deployment" "msteams_conn_deployment" {
  name                = var.msteams_conn_deployment_name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    connections_teams_name = { value = var.teams_api_name }
  })

  template_content = local.msteams_connection_arm_template
}

resource "azurerm_resource_group_template_deployment" "ascalert_conn_deployment" {
  name                = var.ascalert_conn_deployment_name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    connections_ascalert_name = { value = var.ascalert_api_name }
  })

  template_content = local.ascalert_connection_arm_template
}

# NOTE: The connection is no connection string, its the connection id of which provider to use
# Example: /subscriptions/someSubscript/resourceGroups/someResurceGroup/providers/Microsoft.Web/connections/keyvault-2

resource "azurerm_resource_group_template_deployment" "la_deployment" {
  name                = var.logic_app_deployment_name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    logic_app_name      = { value = var.logic_app_name }
    teams_connection    = { value = var.teams_connection },
    ascalert_connection = { value = var.ascalert_connection },
  })

  template_content = local.logic_app_workflow_arm_template
}





