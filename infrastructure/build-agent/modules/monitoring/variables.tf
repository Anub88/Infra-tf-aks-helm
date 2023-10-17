variable "app_env" {
  type = string
}
variable "resource_group_name" {
  type = string
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
variable "virtual_machine_ids" {
  type = list(string)
}
variable "virtual_machine_names" {
  type = list(string)
}
variable "enable_alert" {
  type        = bool
  description = "enable or disable the alert"

}
variable "tags" {
  description = "value for tags"
  type        = map(string)

}
variable "email_address" {
  type = string

}
variable "log_analytics_workspace_id" {
  type = string
}
variable "vm_metric_log" {
  type = object({
    category                 = string
    enabled                  = bool
    retention_policy_enabled = bool
    retention_policy_days    = number
  })
}