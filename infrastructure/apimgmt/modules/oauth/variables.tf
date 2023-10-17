variable "ml_api_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "resource_group_name" {
  type = string
}

variable "authorization_endpoint" {
  type = string
}

variable "token_endpoint" {
  type = string
}

variable "api_management_name" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type      = string
  sensitive = true
}
