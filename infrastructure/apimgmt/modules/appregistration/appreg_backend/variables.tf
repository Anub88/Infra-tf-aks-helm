variable "app_env" {
  type = string
}
variable "name" {
  type = string
}

variable "apim_app_backend_owners" {
  type = list(string)
}
variable "tags" {
  description = "value for tags"
  type        = map(string)

}
variable "key_vault_id" {
  type = string
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "current_object_id" {
  type = string
}
variable "ml_workspace_short_code" {
  type = string
}
variable "app_reg_clients" {
  type = list(string)
}
