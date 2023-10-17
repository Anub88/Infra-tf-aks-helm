variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "apimgmnt_id" {
  type        = string
  description = "The id of the azure api management resource"
}


variable "kv_certificate_id" {
  type = string
}
