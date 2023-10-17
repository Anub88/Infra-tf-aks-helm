output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.vnet_inf.vnet_id
}

output "vnet_subnets_name_id" {
  description = "A mapping from the subnet name to the subnet id of the newly created vNet"
  value       = module.vnet.vnet_subnets_name_id
}

output "vnet_inf_id" {
  description = "The id of the newly created inference vNet"
  value       = module.vnet_inf.vnet_id
}

output "vnet_inf_ref" {
  description = "The reference to the newly created inference vNet"
  value       = module.vnet_inf
}

output "vnet_inf_subnets_name_id" {
  description = "A mapping from the subnet name to the subnet id of the newly created inference vNet"
  value       = module.vnet_inf.vnet_subnets_name_id
}

output "cloud_service_subnet_id" {
  description = "The id of the newly created subnet for cloud services"
  value       = lookup(module.vnet.vnet_subnets_name_id, "snet-${var.ml_workspace_short_code}-${var.app_env}-cloudservice")
}

# TODO: change to a mapping of the name instead of "the 2nd element" for instance.

output "storage_exc_subnet_id" {
  description = "The id of the newly created subnet for storage"
  value       = element(module.vnet_inf.vnet_subnets, 1)
}

output "apim_subnet_id" {
  description = "The id of the newly created subnet for apim"
  value       = element(module.vnet_inf.vnet_subnets, 6)
}
output "cosmodb_subnet_id" {
  description = "The id of the newly created subnet for apim"
  value       = lookup(module.vnet.vnet_subnets_name_id, "snet-${var.ml_workspace_short_code}-${var.app_env}-cosmodb")
}
output "redis_subnet_id" {
  description = "The id of the newly created subnet for redis cache"
  value       = lookup(module.vnet_inf.vnet_subnets_name_id, "snet-${var.ml_inf_short_code}-${var.app_env}-redis")
}
output "vnet_name_ws" {
  value = module.vnet.vnet_name
}

output "vnet_name_ws_id" {
  description = "The id of the newly created vNet"
  value       = module.vnet.vnet_id
}

output "message_broker_subnet_id" {
  description = "The id of subnet for message broker."
  value       = lookup(module.vnet_inf.vnet_subnets_name_id, "snet-${var.ml_inf_short_code}-${var.app_env}-broker")
}

