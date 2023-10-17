variable "app_env" {
  type = string
}
variable "app_reg_backend_name" {
  type = string
}
variable "app_reg_client_names" {
  type = list(string)
}
variable "apim_app_client_owners" {
  type = list(string)
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
variable "current_tenant_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}
variable "current_object_id" {
  type = string
}
variable "ml_workspace_short_code" {
  type = string
}
variable "apim_app_name" {
  type = string
}