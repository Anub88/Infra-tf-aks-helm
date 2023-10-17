variable "acr_config" {
  type = map(any)
}
variable "kv_config" {
  type = any
}
variable "aks_lws_config" {
  type = any
}
variable "vm_config" {
  type = map(any)
}
variable "subnet_id" {
  description = "The cloud service subnet id of the vnet: snet-mlws-dev-cloudservice"
  type        = string
}
variable "vnet_id" {
  description = "The id of the vnet"
  type        = string
}
variable "vnet_inf_id" {
  description = "The id of the inference vnet"
  type        = string
}

variable "vnet_subnets_name_id" {
  type        = any
  description = "map from the id of the subnets in the vnet to the ids"
}

variable "resource_group_name" {
  description = "The name of the resource group to create the container registry in"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "ml_inf_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}
variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}
variable "tags" {

  type = map(string)

}
variable "kv_private_dns_zone_id" {
  type        = string
  description = "id for privatelink.vaultcore.azure.net"
}
variable "acr_private_dns_zone_id" {
  type        = string
  description = "id for privatelink.azurecr.io"
}

variable "action_group_id" {
  type        = string
  description = "id of action group"
}
variable "kv_static_alert_rules" {
  type = map(object({
    name        = string
    description = string
    frequency   = string
    window_size = string
    enabled     = bool
    static_criteria = map(object({
      aggregation      = string
      metric_name      = string
      metric_namespace = string
      operator         = string
      threshold        = number
    }))
  }))
}
variable "kv_dynamic_alert_rules" {
  type = map(object({
    name        = string
    description = string
    frequency   = string
    window_size = string
    enabled     = bool
    dynamic_criteria = map(object({
      metric_name = string
      metric_namespace = string
      aggregation = string
      operator = string
      alert_sensitivity =  string
    }))
  }))
}
variable "cosmodb_offer_type" {
  type = string
}
variable "cosmodb_kind" {
  type = string
}
variable "cosmodb_subnet_id" {
  type = string
}
variable "capabilities" {
  type = list(string)
}
variable "max_interval_in_seconds" {
  type = number
}

variable "max_staleness_prefix" {
  type = number
}
variable "failover_priority" {
  type = number
}
variable "consistency_level" {
  type = string
}
variable "cosmos_private_dns_zone_name_id" {
  type = string
}
variable "log_analytics_workspace_id" {
  type = string
}
#variable "cosmosdb_sql_database_name" {
#  description = "Specifies the name of the Cosmos DB SQL database"
#  type = string
#}
variable "cosmosdb_sql_database_throughput" {
  description = "The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  type = number
}

variable "cosmosdb_sql_collections" {
  type = map(object({
    name = string
    shard_key = string
    throughput = number
    unique_keys = list(string)
    unique = bool
  }))
}

