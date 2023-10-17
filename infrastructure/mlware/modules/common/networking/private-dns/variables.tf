variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vnet_ids" {
  type = map(any)
}
variable "private_dns_zone" {
  type = string
}
variable "dns_resource_group_name" {
  type = string
}