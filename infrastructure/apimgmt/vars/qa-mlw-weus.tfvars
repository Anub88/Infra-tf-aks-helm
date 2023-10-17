app_env             = "qa"
vnet_inf_name       = "vnet-mlif-qa-weus"
resource_group_name = "rg-mlw-qa-weus"
subnet_name         = "snet-mling-qa-apim"

product_name       = "odx-bscan"
subscription_limit = "1"

func_names_list = {
  "bsi-get" = {
    api_spec    = "get-api.yml"
    backend     = false
    backend_url = "http://10.8.0.96"
    operationId = "odxget"
    required    = true
    header      = false
  }
}

auth_client1 = "c6124c69-ebbf-44c7-a376-40b402ccdcda"
auth_client2 = "b6e9b6bf-2c64-4550-ba97-801fded9be60"

secret_key_names = ["apim-auth-client-id", "apim-auth-client-secret"]
flow_log_retention_days      = 7

rate_limit_by_key_policy = {
  "calls": 10
  "renewel_period": 300
  "increment-condition": "@(context.Response.StatusCode == 200|| context.Response.StatusCode == 201)"
  "counter-key": "@(context.Subscription.Id)"
  "remaining-calls-variable-name": "remainingCallsPerSubscription"

}
quota_by_key_policy = {
  "calls": 10
  "renewel_period": 300
  "increment-condition": "@(context.Response.StatusCode == 200|| context.Response.StatusCode == 201)"
  "counter-key": "@(context.Subscription.Id)"
}
