variable "sb_dnszone" {
  type    = string
  default = "privatelink.servicebus.windows.net"
}

variable "location" {
  type = string
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "tags" {
  description = "value for tags"
  type        = map(string)

}

variable "short_code" {
  type        = string
  description = "value for shortcode"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Service Bus queue should exist"
}


variable "app_env" {
  type        = string
  description = "environment"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace"
  type        = string
}

variable "servicebus_zone_id" {
  description = "value"
  type        = string
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
variable "key_vault_id" {
  type = string
}
variable "storage_private_dns_zone_id" {
  type = string
}
variable "current_tenant_object_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}
variable "current_tenant_id" {
  description = "The object id of the tenant for the current azure ad client config"
  type        = string
}
variable "resource_group_id" {
  description = "ID of the resource group to be imported."
  type        = string
}
variable "aks_managed_rg_name" {
  type = string
}
variable "enable_dapr_managed_identity" {
  type = bool
}
variable "enable_dapr_app_registration" {
  type = bool
}
variable "dapr_app_owners" {
  type = list(string)
}
variable "vnet_subnets_name_id" {
  type        = any
  description = "map from the id of the subnets in the vnet to the ids"
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

variable "eventhub_subnet_id" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}


