location               = "West US 2"
region_code            = "weus"
ml_api_short_code      = "mlapi"
ml_workspace_short_code = "mlws"
ml_inference_short_code = "mlif"
authorization_endpoint = "https://login.microsoftonline.com/82913d90-8716-4025-a8e8-4f8dfa42b719/oauth2/v2.0/authorize"
token_endpoint    = "https://login.microsoftonline.com/82913d90-8716-4025-a8e8-4f8dfa42b719/oauth2/v2.0/token"
openid_config_url = "https://login.microsoftonline.com/82913d90-8716-4025-a8e8-4f8dfa42b719/v2.0/.well-known/openid-configuration"

nsg_rules = {
    "endpoint_rule"={
        priority = 100
        port     = "3443"
    }
    "https_rule"={
        priority = 110
        port     = "443"
    }
}
apim_app_backend_owners = ["cc2be70d-17ec-4d4e-a96f-76775d5fbcad","3987fb5a-f450-4ee6-875b-fddc37b62742"]
apim_app_client_owners = ["cc2be70d-17ec-4d4e-a96f-76775d5fbcad","3987fb5a-f450-4ee6-875b-fddc37b62742"]
app_reg_apim_backend_name = "axis-backend-01"
app_reg_apim_client_names = ["axis-client-01"]