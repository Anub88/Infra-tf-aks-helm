variable "resource_group_location" {
  description = "The location of the resource group to create the container registry in"
  type        = string
}
variable "ml_inf_short_code" {
  type        = string
  description = "value for ml-inference shortcode"
}
variable "region_code" {
  type = string
}
variable "environment" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "redis_subnet_id" {
  type = string
}
variable "tags" {

  type = map(string)

}

variable "redis_private_dns_zone_name_id" {
  type = string
}
variable "redis_private_dns_zone_name" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "key_vault_id" {
  type = string
}
variable "redis_private_dns_zone_rg" {
  type = string
}
variable "redis_cache_config" {
  type = object({
    capacity                = number
    family                  = string
    sku_name                = string
    enable_non_ssl_port     = bool
    minimum_tls_version     = string
    shard_count             = number
    redis_subresource_names = list(string)
    redis_configuration = object({
      maxmemory_reserved = number
      maxmemory_delta    = number
      maxmemory_policy   = string
    })
  })
}

variable "log_analytics_workspace_id" {
  type = string
}
