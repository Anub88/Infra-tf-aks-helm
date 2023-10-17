variable "private_dns_zone" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "buildagent_vnet_name" {
  type = string
}
variable "buildagent_vnet_id" {
  type = string
}
variable "tags" {
  type = map(string)
}
