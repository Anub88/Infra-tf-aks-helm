
variable "ml_api_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "resource_group_name" {
  type = string
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "func_names_list" {
  type = any
}

variable "app_insights_name" {
  type = string
}

variable "api_management_name" {
  type = string
}

variable "api_management_id" {
  type = string
}

variable "app_insights_id" {
  type = string
}
variable "app_insights_instrumentation_key" {
  type = string
}
variable "ml_inference_short_code" {
  type        = string
  description = "Ml inference name. Use only lowercase letters and numbers"
}

variable "log_analytics_workspace_id" {
  type = string
}
