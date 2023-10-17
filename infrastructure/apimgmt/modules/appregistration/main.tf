module "appreg_client" {
  for_each                = toset(var.app_reg_client_names)
  source                  = "./appreg_client"
  apim_app_owners         = var.apim_app_client_owners
  app_env                 = var.app_env
  current_object_id       = var.current_object_id
  key_vault_id            = var.key_vault_id
  ml_workspace_short_code = var.ml_workspace_short_code
  name                    = each.key
  region_code             = var.region_code
  tags                    = var.tags
  apim_app_name           = var.apim_app_name
  # app_reg_backend_objectid= module.appreg_backend.app_reg_backend_objectid
}

module "appreg_backend" {
  source                  = "./appreg_backend"
  apim_app_backend_owners = var.apim_app_backend_owners
  app_reg_clients         = [for client in var.app_reg_client_names : module.appreg_client[client].app_reg_apim_client_resource_id]
  app_env                 = var.app_env
  current_object_id       = var.current_object_id
  key_vault_id            = var.key_vault_id
  ml_workspace_short_code = var.ml_workspace_short_code
  name                    = var.app_reg_backend_name
  region_code             = var.region_code
  tags                    = var.tags
}