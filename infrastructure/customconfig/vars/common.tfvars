region_code             = "weus"
ml_inf_short_code       = "mlif"
ml_workspace_short_code = "mlws"
ml_api_short_code       = "mlapi"
environment             = "dev"

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
