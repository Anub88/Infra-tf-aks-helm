variable "resource_group_name" {
  type = string
}
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "resource_group_location" {
  type = string
}
variable "tags" {
  type = map(string)
}