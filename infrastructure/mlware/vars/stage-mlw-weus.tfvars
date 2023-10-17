app_env = "stage"
# vnet subnet cidr range
cidr_space = ["10.9.0.0/16"]

# vnet subnet cidr range
cidr_mlinf         = ["10.10.0.0/16"]



buildagent_rg_name   = "rg-cicd-stage-weus-buildagent"
buildagent_vnet_name = "vnet-cicd-stage-weus-buildagent"

shared_resource_group_name = "rg-mlws-shared-stage-weus"

#email address for alerts
email_address                = "chand.basha@zeiss.com"
#Error: Creating Security Center Contact: security.ContactsClient#Create: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: Service returned an error. Status=400 Code="BadRequest" Message="The json value of securityContactsemailAddresses failed validation, with reason: SecurityContactsEmailAddresses : Security contact with the same email address is already defined for this subscription. Using the same email address for different security contacts is not allowed
#security_center_contact_mail = "ascalerts@zeiss.com"
security_center_contact_mail = "vinay.shetty@zeiss.com"

flow_log_retention_days      = 7
enabled_defender_plans = [
  {
    tier          = "Standard"
    resource_type = "VirtualMachines"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "ContainerRegistry"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "AppServices"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "KeyVaults"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Free"
    resource_type = "Arm"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "Dns"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "Containers"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change

  },
  {
    tier          = "Standard"
    resource_type = "StorageAccounts"
    subplan       = "PerTransaction" #We taken the value from the plan and added that value to mitigate the change
  },
  {
    tier          = "Standard"
    resource_type = "KubernetesService"
    subplan       = "P2" #We taken the value from the plan and added that value to mitigate the change
  }

]
kv_static_alert_rules = {
  KV_AVAILABILITY_BELOW_100PCT = {
    name = "criteria_availability_drops_below_100pct"
    description = "Key Vault Availability drops below 100% (Static Threshold)"
    frequency = "PT1M"
    window_size = "PT5M"
    enabled     = true
    static_criteria = {
      criteria = {
        metric_name = "Availability"
        metric_namespace = "Microsoft.KeyVault/vaults"
        aggregation = "Average"
        operator = "LessThan"
        threshold = 99.9
      }
    }
  },
  KV_LATENCY_GREATER_THAN_500MS = {
    name = "criteria_greater_than_500ms"
    description = "Key Vault Latency is greater than 500ms (Static Threshold)"
    enabled     = true
    frequency = "PT1M"
    window_size = "PT5M"
    static_criteria = {
      criteria = {
        metric_name = "ServiceApiLatency"
        metric_namespace = "Microsoft.KeyVault/vaults"
        aggregation = "Maximum"
        operator= "GreaterThan"
        threshold= 500
      }
    }
  },
  KV_SATURATION_GREATER_THAN_75PCT = {
    name = "criteria_saturation_greater_than_75pct"
    description = "Overall Vault Saturation is greater than 75% (Static Threshold)"
    enabled   = true
    frequency = "PT1M"
    window_size = "PT5M"
    static_criteria = {
      criteria = {
        metric_name = "SaturationShoebox"
        metric_namespace = "Microsoft.KeyVault/vaults"
        aggregation = "Average"
        operator = "GreaterThan"
        threshold = 75
      }
    }
  }
}
kv_dynamic_alert_rules = {
  KV_SATURATION_EXCEEDS_AVERAGE = {
    name = "criteria_saturation_exceeds_avg"
    description = "Overall Vault Saturation exceeds average (Dynamic Threshold)"
    enabled  = true
    frequency = "PT1M"
    window_size = "PT5M"
    dynamic_criteria = {
      criteria = {
        metric_name = "SaturationShoebox"
        metric_namespace = "Microsoft.KeyVault/vaults"
        aggregation = "Average"
        operator = "GreaterThan"
        alert_sensitivity =  "High"
      }
    }
  },
  KV_TOTAL_API_RESULTS_HIGHER_THAN_AVG = {
    name = "criteria_total_api_results_higher_than_avg"
    description = "Total Api results higher than average (Dynamic Threshold)"
    enabled  = true
    frequency = "PT1M"
    window_size = "PT5M"
    dynamic_criteria = {
      criteria = {
        metric_name = "ServiceApiResult"
        metric_namespace = "Microsoft.KeyVault/vaults"
        aggregation = "Average"
        operator = "GreaterThan"
        alert_sensitivity =  "High"
      }
    }
  }
}

#cosmosdb_sql_database_name  = "usecase-mongo-db"
cosmosdb_sql_database_throughput = 400
cosmosdb_sql_collections = {
  usecase-manifest = {
    name = "usecase-manifest"
    shard_key = "value.name"
    throughput = 400
    unique_keys = ["_id"]
    unique = true
  }
  usecase-manifest_archive = {
    name = "usecase-manifest_archive"
    shard_key = "value.name"
    throughput = 400
    unique_keys = ["_id"]
    unique = true
  }
}
redis_cache_config = {
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"
  shard_count         = 1
  redis_subresource_names = ["redisCache"]
  redis_configuration = {
    maxmemory_reserved = 2
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }
}