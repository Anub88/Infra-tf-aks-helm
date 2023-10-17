variable "acr_config" {
  type = map(any)
}

variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
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
variable "vnet_id" {
  description = "The id of the vnet"
  type        = string
}
variable "vnet_inf_id" {
  description = "The id of the inference vnet"
  type        = string
}
variable "tags" {

  type = map(string)

}

variable "subnet_id" {
  description = "The cloud service subnet id of the vnet: snet-mlws-dev-cloudservice"
  type        = string
}
variable "private_dns_zone_id" {
  description = "The dns zone id for privatelink.azurecr.io"
  type        = string
}
