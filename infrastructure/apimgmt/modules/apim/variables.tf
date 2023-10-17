
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

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "key_vault_id" {
  type = string
}

variable "current_user_tenant_id" {
  type = string
}