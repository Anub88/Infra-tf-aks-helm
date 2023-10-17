variable "aks_node_pools" {
  type = any
}

variable "aks_config" {
  type = any
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

variable "vnet_subnets_name_id" {
  type        = any
  description = "map from the id of the subnets in the vnet to the ids"
}

variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace"
  type        = string
}
variable "log_analytics_workspace_workspace_id" {
  description = "The workspace of the log analytics workspace"
  type        = string
}
variable "flow_log_retention_days" {
  description = "The number of days nsg flow logs are retained in storage"
  type        = number
}

variable "acr_id" {
  description = "The id of the container registry"
  type        = string
}
variable "tags" {
  type = map(string)
}
variable "current_tenant_id" {
  description = "The tenant id of the current azure subscription"
  type        = string
}
variable "dapr_version" {
  type    = string
  default = "1.9.5"
}
variable "dapr_config_settings" {
  type = string
}
variable "dapr_update" {
  type = string
}
variable "pod_max_pid" {
  type = number
}
