variable "location" {
  type = string
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "linux_vm_config" {
  type = map(any)
}
variable "cidr_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."

}

variable "kv_config" {
  type = any
}

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

variable "pat" {
  type = string
}

variable "pool" {
  type = string
}

variable "url" {
  type = string
}

variable "acr_config" {
  type = map(any)
}
variable "ml_workspace_short_code" {
  type = string
}

variable "public_acr_repos" {
  type = list(string)
}

variable "log_analytics_workspace_initial" {
  type = string
}

variable "lws_env" {
  type        = string
  description = "log analytics workspace env name. Use only lowercase letters and numbers"
}

variable "vm_monitor_metric_alerts" {
  type = list(object({
    name             = string
    description      = string
    severity         = number
    frequency        = string
    window_size      = string
    aggregation      = string
    metric_name      = string
    metric_namespace = string
    operator         = string
    threshold        = number
  }))
}
variable "email_address" {
  type    = string

}
variable "enable_alert" {
  type        = bool
  description = "enable or disable the alert"

}

variable "vm_metric_log" {
  type = object({
    category                 = string
    enabled                  = bool
    retention_policy_enabled = bool
    retention_policy_days    = number
  })
}
