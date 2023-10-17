app_env             = "dev"
vnet_inf_name       = "vnet-mlif-dev-weus"
resource_group_name = "rg-mlw-dev-weus"
subnet_name         = "snet-mling-dev-apim"

product_name       = "odx-bscan"
subscription_limit = "1"

func_names_list = {
  "bsi-get" = {
    api_spec    = "get-api.yml"
    backend     = false
    backend_url = "http://10.6.0.96"
    operationId = "odxget"
    required    = true
    header      = false
  }
}

auth_client1 = "666d27d4-2b19-4c50-8860-377fb1f77ef4"
auth_client2 = "650b2ed8-2fb8-44c1-bcb6-282d9ba7cb78"

secret_key_names = ["apim-auth-client-id", "apim-auth-client-secret"]
flow_log_retention_days      = 7

rate_limit_by_key_policy = {
  "calls": 10
  "renewel_period": 300
  "increment-condition": "@(context.Response.StatusCode == 200 || context.Response.StatusCode == 201)"
  "counter-key": "@(context.Subscription.Id)"
  "remaining-calls-variable-name": "remainingCallsPerSubscription"

}
quota_by_key_policy = {
  "calls": 10
  "renewel_period": 300
  "increment-condition": "@(context.Response.StatusCode == 200 || context.Response.StatusCode == 201)"
  "counter-key": "@(context.Subscription.Id)"
}


