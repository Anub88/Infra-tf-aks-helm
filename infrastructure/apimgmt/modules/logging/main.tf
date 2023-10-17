resource "azurerm_api_management_logger" "app_insight_log" {
  name                = var.app_insights_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  resource_id         = var.app_insights_id
  application_insights {
    instrumentation_key = var.app_insights_instrumentation_key
  }
}

resource "azurerm_api_management_api_diagnostic" "apimapidiagnostic" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["required"]
  }
  identifier               = "applicationinsights"
  resource_group_name      = var.resource_group_name
  api_management_name      = var.api_management_name
  api_name                 = each.key
  api_management_logger_id = azurerm_api_management_logger.app_insight_log.id

  sampling_percentage       = 10.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}

# Note for future editors:
#   resource "azurerm_api_management_diagnostic" "apimdiagnostic"
#   conflicts with the app insights defined above

# The provider doesn't set appropiate defaults for all categories, therefore we need to manually specify
# them in order not to have pollution in plans.

resource "azurerm_monitor_diagnostic_setting" "apim_ds" {
  name                       = "diagnostic-logs-${var.ml_inference_short_code}-${var.app_env}"
  target_resource_id             = var.api_management_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "AzureDiagnostics"

  log {
    category = "GatewayLogs"

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  log {
    category = "WebSocketConnectionLogs"

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

