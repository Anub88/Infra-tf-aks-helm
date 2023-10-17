
variable "vm_config" {
  type = map(any)
}

variable "vm_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "resource_group_location" {
  type = string
}

variable "kv_config" {
  type = any
}

variable "subnet_id" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "computer_name" {
  type = string
}

variable "pat" {
  type = string
}

variable "pool" {
  type = string
}

variable "agent_name_linux" {
  type = string
}

variable "url" {
  type = string
}
variable "bootstrap_agent" {
  type = bool
}
variable "recovery_vault_name" {
  type = string
}
variable "backup_policy_id" {
  type = string
}
