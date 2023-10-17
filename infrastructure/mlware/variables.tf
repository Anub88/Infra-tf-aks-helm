## General variable

variable "ml_inf_short_code" {
  type        = string
  description = "value for ml-inference shortcode"
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

variable "location" {
  type = string
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "proj_name" {
  type        = string
  description = "proj_name or team name . Use only lowercase letters and numbers "
}

## Azure Environment Name

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

## Vnet
variable "cidr_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.4.0.0/16"]
}

variable "cidr_mlinf" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}

## AKS

variable "aks_node_pools" {
  type = any
}

variable "aks_config" {
  type = any
}

variable "aks_lws_config" {
  type = any
}


# Azure container registry
variable "acr_config" {
  type = map(any)
}

# key vault
variable "kv_config" {
  type = any
}

# VM
variable "vm_config" {
  type = any
}
variable "buildagent_rg_name" {
  type = string
}

variable "buildagent_vnet_name" {
  type = string
}
variable "dns_names" {
  type = list(string)
}
variable "shared_resource_group_name" {
  type = string
}
variable "kv_private_dns_zone_name" {
  type    = string
  default = "privatelink.vaultcore.azure.net"
}
variable "acr_private_dns_zone_name" {
  type    = string
  default = "privatelink.azurecr.io"
}

variable "servicebus_private_dns_zone_name" {
  type    = string
  default = "privatelink.servicebus.windows.net"
}

variable "key_vault_secret_expiration_date" {
  type = string
}

variable "email_address" {
  type = string
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

variable "enabled_defender_plans" {
  type = list(object({
    tier          = string
    resource_type = string
    subplan       = string
  }))
}
variable "security_center_contact_mail" {
  type    = string
  default = "ascalerts@zeiss.com"
}
variable "flow_log_retention_days" {
  description = "The number of days nsg flow logs are retained in storage"
  type        = number
}
variable "storage_private_dns_zone_name" {
  type = string
}
variable "cosmos_private_dns_zone_name" {
  type = string
}
variable "redis_private_dns_zone_name" {
  type = string
}
variable "enable_dapr_managed_identity" {
  type = bool
}
variable "enable_dapr_app_registration" {
  type = bool
}
variable "dapr_app_owners" {
  type    = list(string)
  default = []
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
      metric_name       = string
      metric_namespace  = string
      aggregation       = string
      operator          = string
      alert_sensitivity = string
    }))
  }))
}


variable "region" {
  type        = string
  description = "Region used for Azure Dashboard"
}

variable "pod_max_pid" {
  type        = number
  description = "The maximum amount of process IDs that can be running in a Pod"
  default     = -1
}
variable "cosmodb_offer_type" {
  type = string
}
variable "cosmodb_kind" {
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

variable "compatibility_level" {
  type    = string

}
variable "data_locale" {
  type    = string

}
variable "events_late_arrival_max_delay_in_seconds" {
  type    = number

}
variable "events_out_of_order_max_delay_in_seconds" {
  type    = number

}
variable "events_out_of_order_policy" {
  type = string
}
variable "output_error_policy" {
  type    = string

}
variable "streaming_units" {
  type    = number

}
variable "start_mode" {
  type    = string

}
variable "eventhub_names" {
  type    = map(string)

}
variable "shared_access_policy_name" {
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