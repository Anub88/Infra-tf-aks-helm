locals {
  sql_query = join("\n", [
    for k, v in var.eventhub_names : <<QUERY
    SELECT *
    INTO [asa-${k}-${var.ml_inf_short_code}-${var.app_env}${var.region_code}-output]
    FROM [asa-${k}-${var.ml_inf_short_code}-${var.app_env}${var.region_code}-input]
QUERY
  ])

}
resource "azurerm_eventhub_consumer_group" "eventhub_consumer_group" {
  for_each            = var.eventhub_names
  name                = "asa-${each.key}-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-cg"
  eventhub_name       = each.value
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_stream_analytics_job" "asa" {
  name                                     = "asa-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  compatibility_level                      = var.compatibility_level
  data_locale                              = var.data_locale
  events_late_arrival_max_delay_in_seconds = var.events_late_arrival_max_delay_in_seconds
  events_out_of_order_max_delay_in_seconds = var.events_out_of_order_max_delay_in_seconds
  events_out_of_order_policy               = var.events_out_of_order_policy
  output_error_policy                      = var.output_error_policy
  streaming_units                          = var.streaming_units

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags

  transformation_query = local.sql_query

}


resource "azurerm_stream_analytics_stream_input_eventhub_v2" "asa_eventhub_input" {
  for_each                     = var.eventhub_names
  name                         = "asa-${each.key}-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-input"
  stream_analytics_job_id      = azurerm_stream_analytics_job.asa.id
  eventhub_consumer_group_name = azurerm_eventhub_consumer_group.eventhub_consumer_group[each.key].name
  eventhub_name                = azurerm_eventhub_consumer_group.eventhub_consumer_group[each.key].eventhub_name
  servicebus_namespace         = var.eventhub_namespace_name
  shared_access_policy_key     = var.eventhub_default_primary_key
  shared_access_policy_name    = var.shared_access_policy_name

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_blob" "asa_eventhub_container_output" {
  for_each                  = var.eventhub_names
  name                      = "asa-${each.key}-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-output"
  stream_analytics_job_name = azurerm_stream_analytics_job.asa.name
  resource_group_name       = var.resource_group_name
  storage_account_name      = var.job_storage_account_name
  storage_account_key       = var.eventhub_storage_account_primary_access_key
  storage_container_name    = var.job_storage_account_name
  date_format               = "yyyy-MM-dd"
  time_format               = "HH"
  path_pattern              = azurerm_eventhub_consumer_group.eventhub_consumer_group[each.key].eventhub_name
  serialization {
    type            = "Csv"
    encoding        = "UTF8"
    field_delimiter = ","
  }
}
