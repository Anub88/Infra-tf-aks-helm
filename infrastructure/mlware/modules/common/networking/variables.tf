variable "ml_inf_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}
variable "ml_api_short_code" {
  type        = string
  description = "Ml API name. Use only lowercase letters and numbers"
}
variable "ml_workflow_short_code" {
  type        = string
  description = "Ml Workflow Engine name. Use only lowercase letters and numbers"
}
variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}
variable "ml_ingestion_short_code" {
  type        = string
  description = "Ml Ingestion name. Use only lowercase letters and numbers"
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}
variable "cidr_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.4.0.0/16"]
}
variable "cidr_mlinf" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}
variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}
variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}
variable "buildagent_rg_name" {
  type = string
}
variable "buildagent_vnet_name" {
  type = string
}

variable "buildagent_vnet_id" {
  type = string
}
variable "tags" {

  type = map(string)

}

variable "dns_names" {
  type = list(string)
}
variable "vnet_location" {
  type = string
}
variable "shared_resource_group_name" {
  type = string
}