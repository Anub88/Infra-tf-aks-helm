variable "resource_group_id" {
  description = "ID of the resource group to be imported."
  type        = string
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
variable "current_tenant_object_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}

variable "current_tenant_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}
variable "key_vault_id" {
  type = string
}
variable "key_vault_secret_expiration_date" {
  type = string
}
