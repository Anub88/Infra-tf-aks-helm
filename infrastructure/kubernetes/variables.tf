
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "environment" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "subscription_id" {
  type        = string
  description = "azure subscription id from environment"
}

variable "ml_inf_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "project_name" {
  type        = string
  description = "project_name or team name . Use only lowercase letters and numbers "
}

variable "linux_node_pool" {
  type        = string
  description = "linux nodepool name"
}

variable "windows_node_pool" {
  type        = string
  description = "windows node pool name"
}

variable "hdp_base_domain" {
  type        = string
  description = "HDP base domain / URL"
}

variable "hdp_auth_domain" {
  type        = string
  description = "HDP auth domain / URL"
}

variable "zeissid_api_domain" {
  type        = string
  description = "Zeiss ID Api domain / URL"
}

variable "kubernetes_services" {
  type = map(object({
    tag: string
    replica_count: number
    name: string
  }))
}