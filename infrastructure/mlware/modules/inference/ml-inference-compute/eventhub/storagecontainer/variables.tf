variable "location" {
  type = string
}
variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Service Bus queue should exist"
}
variable "st_account_tier" {
  type        = string
  description = "value for the account tier"
  default     = "Standard"
}
variable "st_account_replication_type" {
  type        = string
  description = "value for Replication type"
  default     = "LRS"
}
variable "tags" {
  description = "value for tags"
  type        = map(string)

}
variable "short_code" {
  type        = string
  description = "value for shortcode"
}
variable "app_env" {
  type        = string
  description = "environment"
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "key_vault_id" {
  type = string
  description = "The ID of the Key Vault"
}
variable "subnet_id" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "storage_private_dns_zone_id" {
  type = string
}
variable "ml_inf_short_code" {
  type = string
  description = "value for ml-inference shortcode"
}
variable "log_analytics_workspace_workspace_id" {
  type = string
  description = "Specifies the name of the Log Analytics Workspace id"
}
variable "log_analytics_workspace_resource_id" {
  type = string
  description = "The resource ID of the attached workspace"
}
variable "flow_log_retention_days" {
  type        = string
  description = "The number of days to retain flow log records."
}
variable "module_aks_nsg_flowlog_storage_id" {
  type = string
  description = "nsg flow log storage id"
}
variable "network_watcher_name" {
  type = string
  description = "The name of the Network Watcher. Changing this forces a new resource to be created"
}
