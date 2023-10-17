
output "aks_id" {
  description = "The id of the aks"
  value       = module.aks.aks_id
}

output "aks_name" {
  description = "The id of the aks"
  value       = module.aks.aks_name
}

output "eventhub_namespace_id" {
  description = "The id of the newly created eventhub namespace"
  value       = module.eventhub.eventhub_namespace_id
}


output "eventhub_namespace_name" {
  description = "The Name of the newly created eventhub namespace"
  value       = module.eventhub.eventhub_namespace_name
}
output "eventhub_storage_account_name" {
  value = module.eventhub.eventhub_storage_account_name
}
output "eventhub_default_primary_key" {
  value = module.eventhub.eventhub_default_primary_key
}

output "eventhub_storage_account_primary_access_key" {
  value = module.eventhub.eventhub_storage_account_primary_access_key
}