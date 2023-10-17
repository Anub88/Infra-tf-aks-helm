variable "kv_config" {
  type = any
}

variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "ml_inf_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "vnet_id" {
  description = "The id of the vnet"
  type        = string
}

variable "tags" {

  type = map(string)

}

variable "private_dns_zone_id" {
  type = string
}
variable "kv_subnet_id" {
  type = string
}

variable "action_group_id" {
  type = string
}
variable "kv_static_alert_rules" {
  type = map(object({
    name        = string
    description = string
    frequency   = string
    window_size = string
    enabled     = bool
    static_criteria = map(object({
      aggregation      = string
      metric_name      = string
      metric_namespace = string
      operator         = string
      threshold        = number
    }))
  }))
}
variable "kv_dynamic_alert_rules" {
  type = map(object({
    name        = string
    description = string
    frequency   = string
    window_size = string
    enabled     = bool
    dynamic_criteria = map(object({
      metric_name = string
      metric_namespace = string
      aggregation = string
      operator = string
      alert_sensitivity =  string
    }))
  }))
}