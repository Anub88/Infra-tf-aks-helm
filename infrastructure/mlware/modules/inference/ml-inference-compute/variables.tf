variable "aks_node_pools" {
  type = any
}

variable "aks_config" {
  type = any
}

variable "ml_inf_short_code" {
  type        = string
  description = "value for ml-inference shortcode"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "vnet_inf_subnets_name_id" {
  type        = any
  description = "id of the subnets in the inference vnet"
}

variable "vnet_id" {
  description = "The id of the vnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_id" {
  description = "The id of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace"
  type        = string
}
variable "log_analytics_workspace_resource_id" {
  type = string
}
variable "log_analytics_workspace_workspace_id" {
  description = "The id of the log analytics workspace"
  type        = string
}

variable "acr_id" {
  description = "The id of the container registry"
  type        = string
}
variable "aks_pvt_dns_vnet_id" {
  type = any
}
variable "tags" {
  type = map(string)
}

variable "location" {
  type = string
}


variable "current_tenant_id" {
  description = "The tenant id of the current azure subscription"
  type        = string
}

variable "dapr_version" {
  type    = string
  default = "1.9.5"
}
variable "dapr_config_settings" {
  type = string
}
variable "dapr_update" {
  type = string
}
variable "flow_log_retention_days" {
  description = "The number of days nsg flow logs are retained in storage"
  type        = number
}

variable "eventhub_sku" {
  type        = string
  description = "sku defined based on scenario"
}

variable "servicebus_zone_id" {
  description = "value"
  type        = string
}
variable "key_vault_id" {
  type = string
}
variable "storage_private_dns_zone_id" {
  type = string
}
variable "current_tenant_object_id" {
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
variable "eventhub_subnet_id" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "pod_max_pid" {
  type = number
}
variable "redis_subnet_id" {
  type = string
}
variable "redis_private_dns_zone_name_id" {
  type = string
}
variable "redis_private_dns_zone_name" {
  type = string
}
variable "redis_private_dns_zone_rg" {
  type = string
}
variable "redis_cache_config" {
  type = object({
    capacity            = number
    family              = string
    sku_name            = string
    enable_non_ssl_port = bool
    minimum_tls_version = string
    shard_count         = number
    redis_subresource_names = list(string)
    redis_configuration = object({
      maxmemory_reserved = number
      maxmemory_delta    = number
      maxmemory_policy   = string
    })
  })
}