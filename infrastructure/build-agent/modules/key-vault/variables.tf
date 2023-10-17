variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "tenant_id" {
  type = string
}

variable "kv_config" {
  type = map(any)
}

variable "object_id" {
  type = string
}
variable "linuxvm_name" {
  type = string
}
