resource "azurerm_application_insights" "monitoring_appinsight" {
  name                = "ins-${var.app_env}-${var.region_code}"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
  workspace_id        = var.log_analytics_workspace_id
  tags                = var.tags
}

# Defender Plans
resource "azurerm_security_center_subscription_pricing" "defender_for_x" {
  for_each      = { for i, v in var.enabled_defender_plans : i => v }
  tier          = each.value.tier
  resource_type = each.value.resource_type
  #subplan       = try (each.value.subplan, "") #We taken the value from the plan and added that value to mitigate the change
}

resource "azurerm_security_center_subscription_pricing" "defender_for_vms" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
  subplan       = "P2"  #We taken the value from the plan and added that value to mitigate the change
}
resource "azurerm_security_center_contact" "mdc_contact" {
  email               = var.security_center_contact_mail
  phone               = "1234" #This is the dummy number taken in the plan we have added that value to mitigate the change
  alert_notifications = true
  alerts_to_admins    = true
}

resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = "AIXSalt${var.app_env}"
  resource_group_name = var.resource_group_name
  short_name          = "AIXSalt${var.app_env}"
  enabled             = var.enable_alert
  email_receiver {
    name                    = "AIXSDevops"
    email_address           = var.email_address
    use_common_alert_schema = true
  }
  tags = var.tags
}
module "stream_analytics_job" {
  source                                   = "./stream_analytics_job"
  app_env                                  = var.app_env
  eventhub_namespace_name                  = var.eventhub_namespace_name
  job_storage_account_name                 = var.eventhub_storage_account_name
  location                                 = var.location
  ml_inf_short_code                        = var.ml_inf_short_code
  region_code                              = var.region_code
  resource_group_name                      = var.resource_group_name
  shared_access_policy_name                = var.shared_access_policy_name
  tags                                     = var.tags
  compatibility_level                      = var.compatibility_level
  data_locale                              = var.data_locale
  eventhub_names                           = var.eventhub_names
  events_late_arrival_max_delay_in_seconds = var.events_late_arrival_max_delay_in_seconds
  events_out_of_order_max_delay_in_seconds = var.events_out_of_order_max_delay_in_seconds
  events_out_of_order_policy               = var.events_out_of_order_policy
  output_error_policy                      = var.output_error_policy
  start_mode                               = var.start_mode
  streaming_units                          = var.streaming_units
  eventhub_default_primary_key             = var.eventhub_default_primary_key
  eventhub_storage_account_primary_access_key = var.eventhub_storage_account_primary_access_key
}