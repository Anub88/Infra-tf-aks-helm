variable "ml_workspace_short_code" {
  type = string
}
variable "region_code" {
  type = string
}
variable "environment" {
  type = string
}
variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}
variable "resource_group_name" {
  type = string
}
variable "cosmodb_offer_type" {
  type = string
}
variable "cosmodb_kind" {
  type = string
}

variable "tags" {

  type = map(string)

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
variable "key_vault_id" {
  description = "keyvault id"
  type = string
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