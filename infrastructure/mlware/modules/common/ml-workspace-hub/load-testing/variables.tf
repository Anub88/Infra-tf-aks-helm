variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}

variable "tags" {
  type = map(string)
}