variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "region_code" {
  type = string
}

variable "app_env" {
  type = string
}

variable "ml_inf_short_code" {
  type = string
}
variable "job_storage_account_name" {
  type = string
}


variable "shared_access_policy_name" {
  type = string
}
variable "eventhub_namespace_name" {
  type = string
}
variable "eventhub_names" {
  type = map(string)

}

variable "compatibility_level" {
  type = string

}
variable "data_locale" {
  type = string

}
variable "events_late_arrival_max_delay_in_seconds" {
  type = number

}
variable "events_out_of_order_max_delay_in_seconds" {
  type = number

}
variable "events_out_of_order_policy" {
  type = string

}
variable "output_error_policy" {
  type = string

}
variable "streaming_units" {
  type = number

}
variable "start_mode" {
  type = string

}
variable "eventhub_default_primary_key" {
  type = string
}
variable "eventhub_storage_account_primary_access_key" {
  type = string
}