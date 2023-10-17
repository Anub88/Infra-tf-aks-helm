variable "buildagent_resource_group" {
  type = string
}

variable "buildagent_vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_names" {
  type = list(string)
}

variable "resource_group_location" {
  type = string
}

variable "lg_vuln_not_name" {
  type = string
}

variable "lg_vuln_not_kv_conn" {
  type = string
}

variable "lg_vuln_not_kv_name" {
  type = string
}

variable "lg_vuln_not_kv_rg" {
  type = string
}

variable "lg_vuln_not_kv_api_name" {
  type = string
}

variable "lg_vuln_not_office_api_name" {
  type = string
}

variable "lg_vuln_not_office_conn" {
  type = string
}

variable "lg_vuln_not_logicapp_deployment_name" {
  type = string
}

variable "lg_vuln_not_app_reg_name" {
  type = string
}

variable "lg_vuln_not_kv_deployment_name" {
  type = string
}

variable "lg_vuln_not_office_deployment_name" {
  type = string
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

variable "lg_cld_alert_name" {
  type = string
}

variable "lg_cld_alert_msteams_conn" {
  type = string
}

variable "lg_cld_alert_asc_conn" {
  type = string
}

variable "lg_cld_alert_teams_api_name" {
  type = string
}

variable "lg_cld_alert_asc_api_name" {
  type = string
}

variable "lg_cld_alert_logicapp_deployment_name" {
  type = string
}

variable "lg_cld_alert_msteams_deployment_name" {
  type = string
}

variable "lg_cld_alert_asc_deployment_name" {
  type = string
}

