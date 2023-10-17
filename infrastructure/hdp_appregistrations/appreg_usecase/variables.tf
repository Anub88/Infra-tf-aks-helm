variable "app_env" {
  type        = string
  description = "environment"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "key_vault_id" {
  type = string
}

variable "current_tenant_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}
variable "tags" {
  description = "value for tags"
  type        = map(string)

}
variable "current_tenant_object_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}

variable "appreg_aixs_app_owners" {
  type = list(string)
}

variable "usecase" {
 type        = string
}