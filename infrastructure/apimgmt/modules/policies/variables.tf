variable "func_names_list" {
  type = any
}

variable "auth_client1" {
  type = string
}

variable "auth_client2" {
  type = string
}

variable "openid_config_url" {
  type = string
}

variable "api_management_id" {
  type = string
}

variable "api_management_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "rate_limit_by_key_policy" {
  type = object({
    calls: number
    renewel_period: number
    increment-condition: string
    counter-key: string
    remaining-calls-variable-name: string

  })
}
variable "quota_by_key_policy" {
  type = object({
    calls: number
    renewel_period: number
    increment-condition: string
    counter-key: string

  })
}