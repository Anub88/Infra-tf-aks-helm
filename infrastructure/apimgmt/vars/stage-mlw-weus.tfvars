app_env             = "stage"
vnet_inf_name       = "vnet-mlif-stage-weus"
resource_group_name = "rg-mlw-stage-weus"
subnet_name         = "snet-mling-stage-apim"

product_name       = "odx-bscan"
subscription_limit = "1"

func_names_list = {
  "bsi-get" = {
    api_spec    = "get-api.yml"
    backend     = false
    backend_url = "http://10.10.0.94"
    operationId = "odxget"
    required    = true
    header      = false
  }
}

auth_client1 = "c4063afe-b0e7-47ad-89fb-31492934f191"
auth_client2 = "9121d458-4471-4270-893c-38a258428862"

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
