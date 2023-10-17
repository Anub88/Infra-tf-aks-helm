variable "acr_config" {
  type = map(any)
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "tags" {
  type = map(string)
}

variable "acr_repositories" {
  description = "The repository names"
  type = list
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
  type = string
}
