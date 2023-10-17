variable "app_env" {
  type        = string
  description = "environment"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "environment" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "appreg_aixs_app_owners" {
  type = list(string)
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "usecases" {
 type        = list(string)
}