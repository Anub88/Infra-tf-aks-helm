variable "log_analytics_workspace_id" {
  type = string
}

variable "resource_ids" {
  type = any
}
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}
