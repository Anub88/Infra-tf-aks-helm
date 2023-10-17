variable "virtual_network_peering_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "remote_virtual_network_id" {
  type = any
}

variable "tags" {
  description = "value for tags"
  type        = map(string)

}