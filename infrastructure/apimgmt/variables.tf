variable "location" {
  type = string
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "sku_apim" {
  type    = string
  default = "Premium_1"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "publisher_name" {
  type    = string
  default = "CZMED AIXS"
}

variable "publisher_email" {
  type    = string
  default = "chand.basha@zeiss.com"
}

variable "ml_api_short_code" {
  type        = string
  description = "Ml API name. Use only lowercase letters and numbers"
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "ml_inference_short_code" {
  type        = string
  description = "Ml inference name. Use only lowercase letters and numbers"
}

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

variable "vnet_inf_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "authorization_endpoint" {
  type = string
}

variable "token_endpoint" {
  type = string
}

variable "func_names_list" {
  type = any
}

variable "product_name" {
  type = string
}

variable "subscription_limit" {
  type = string
}

variable "auth_client1" {
  type = string
}

variable "auth_client2" {
  type = string
}

variable "secret_key_names" {
  type = any
}

variable "openid_config_url" {
  type = string
}

variable "flow_log_retention_days" {
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

variable "nsg_rules" {
type = map(object({
  priority: number
  port: string
}))
}

variable "apim_app_backend_owners" {
  type = list(string)
  description = "App owners for APIM Axis backend registration"
}

variable "apim_app_client_owners" {
  type = list(string)
  description = "App owners for APIM Axis client registration"
}
variable "app_reg_apim_backend_name" {
  type = string
  description = "App registration name for apim backend"
}
variable "app_reg_apim_client_names" {
  type = list(string)
  description = "App registration name for apim client"
}