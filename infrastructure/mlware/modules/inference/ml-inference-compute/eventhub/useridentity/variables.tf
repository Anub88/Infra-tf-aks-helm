variable "app_env" {
  type        = string
  description = "environment"
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "short_code" {
  type        = string
  description = "value for shortcode"
}
variable "key_vault_id" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  description = "value for tags"
  type        = map(string)
}
variable "aks_managed_rg_name" {
  type = string
}
variable "eventhub_namespace_id" {
  type = string
}