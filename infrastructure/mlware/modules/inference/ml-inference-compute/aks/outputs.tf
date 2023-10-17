output "managed_rg_name" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "Resource Group name managed by Microsoft when creating the cluster"
}
output "private_dns_zone_name" {
  value       = local.private_dns_zone_name
  description = "Zone Name for the Private DNS Zone generated by private AKS"
}
output "private_dns_zone_id" {
  value       = local.private_dns_zone_id
  description = "Resource Id for the Private DNS Zone generated by private AKS"
} # Define outputs for module

output "aks_principal_id" {
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  description = "Principal Id for the AKS"
}

output "aks_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "Id for the AKS"
}

output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Name for the AKS"
}

#################
output "nsg_flowlog_storage_id" {
  value       = azurerm_storage_account.nsg_flowlog_storage.id
  description = "Id for NSG flowlog storage"
}

output "network_watcher_name" {
  value       = azurerm_network_watcher_flow_log.aks_flow_logs.network_watcher_name
  description = "name of network watcher "
}
