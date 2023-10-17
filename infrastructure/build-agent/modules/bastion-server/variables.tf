variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}
variable "resource_group_location" {
  description = "Location of the resource group to be imported."
  type        = string
}
variable "bastion_subnet_id" {
  description = "The bastion subnet id for bastion."
  type        = string
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}
variable "tags" {
  type = map(string)
}