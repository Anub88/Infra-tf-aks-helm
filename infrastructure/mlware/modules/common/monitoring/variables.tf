variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}


variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "location" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "tags" {
  description = "value for tags"
  type        = map(string)

}

variable "enable_alert" {
  type        = bool
  description = "enable or disable the alert"
  default     = true
}

variable "email_address" {
  type    = string
  default = "chand.basha@zeiss.com"
}

variable "security_center_contact_mail" {
  type    = string
  default = "ascalerts@zeiss.com"
}

variable "enabled_defender_plans" {
  type = list(object({
    tier          = string
    resource_type = string
    subplan       = string
  }))
}

variable "eventhub_namespace_name" {
  type = string
}
variable "eventhub_storage_account_name" {
  type = string
}
variable "ml_inf_short_code" {
  type = string
}
variable "shared_access_policy_name" {
  type = string
}
variable "compatibility_level" {
  type = string
}
variable "data_locale" {
  type = string
}
variable "eventhub_names" {
  type = map(string)
}
variable "events_late_arrival_max_delay_in_seconds" {
  type    = number

}
variable "events_out_of_order_max_delay_in_seconds" {
  type    = number

}
variable "events_out_of_order_policy" {
  type = string
}
variable "output_error_policy" {
  type    = string

}
variable "streaming_units" {
  type    = number

}
variable "start_mode" {
  type    = string

}
variable "eventhub_default_primary_key" {
  type = string
}
variable "eventhub_storage_account_primary_access_key" {
  type = string
}