location    = "West US 2"
region      = "westus2"
region_code = "weus"
proj_name   = "mlw"

ml_inf_short_code       = "mlif"
ml_api_short_code       = "mlapi"
ml_workflow_short_code  = "mlwf"
ml_workspace_short_code = "mlws"
ml_ingestion_short_code = "mling"

kv_config = {
  soft_delete_days              = "7"
  purge_protection              = "true"
  sku                           = "standard"
  public_network_access_enabled = false

}

acr_config = {
  sku                           = "Premium"
  public_network_access_enabled = false
  pip_allocation_method         = "Static"
  pip_sku                       = "Standard"
  content_trust                 = true
  quarantine_policy_enabled     = false

}

vm_config = {
  size                            = "Standard_D2s_v3"
  admin_username                  = "vmadmin"
  disable_password_authentication = false
  caching                         = "ReadWrite"
  storage_account_type            = "Premium_LRS"
  disk_size_gb                    = 128
  publisher                       = "Canonical"
  offer                           = "0001-com-ubuntu-server-focal"
  sku                             = "20_04-lts-gen2"
  version                         = "latest"
  identity_type                   = "SystemAssigned"

}
aks_config = {
  private_cluster_enabled = true
  kubernetes_version      = "1.25.5"
  type                    = "VirtualMachineScaleSets"
  name                    = "default"
  node_count              = 3
  vm_size                 = "Standard_DS3_v2"
  os_disk_size_gb         = 50
  enable_auto_scaling     = true
}

aks_node_pools = {
  "linuxcpu" = {
    vm_size    = "Standard_D5_v2"
    node_count = 1
    required   = false
    os_type    = "Linux"
  }

  "wincpu" = {
    vm_size    = "Standard_DS3_v2"
    node_count = 1
    required   = true
    os_type    = "Windows"
  }
  "linuxgpu" = {
    vm_size    = "Standard_DS3_v2"
    node_count = 1
    required   = false
    os_type    = "Linux"
  }
}
aks_lws_config = {
  sku               = "PerGB2018"
  retention_in_days = "60"

}



dns_names = ["privatelink.azurecr.io", "privatelink.azurewebsites.net", "privatelink.documents.azure.com", "privatelink.vaultcore.azure.net", "privatelink.servicebus.windows.net", "privatelink.eventgrid.azure.net", "privatelink.table.core.windows.net", "privatelink.redis.cache.windows.net", "privatelink.blob.core.windows.net"]

kv_private_dns_zone_name         = "privatelink.vaultcore.azure.net"
acr_private_dns_zone_name        = "privatelink.azurecr.io"
servicebus_private_dns_zone_name = "privatelink.servicebus.windows.net"
storage_private_dns_zone_name    = "privatelink.blob.core.windows.net"
cosmos_private_dns_zone_name     = "privatelink.mongo.cosmos.azure.com"
redis_private_dns_zone_name      = "privatelink.redis.cache.windows.net"
key_vault_secret_expiration_date = "2023-11-30T00:00:00Z"

dapr_version         = "1.9.5"
dapr_config_settings = "global.ha.enabled=true"
dapr_update          = "false"

enable_dapr_app_registration = true
enable_dapr_managed_identity = true

dapr_app_owners         = ["3987fb5a-f450-4ee6-875b-fddc37b62742", "cc2be70d-17ec-4d4e-a96f-76775d5fbcad"]
cosmodb_kind            = "MongoDB"
cosmodb_offer_type      = "Standard"
capabilities            = ["EnableMongo", "MongoDBv3.4"]
max_interval_in_seconds = 5
max_staleness_prefix    = 100
failover_priority       = 0
consistency_level       = "Session"

pod_max_pid = 100

compatibility_level                      = "1.2"
data_locale                              = "en-GB"
events_late_arrival_max_delay_in_seconds = 60
events_out_of_order_max_delay_in_seconds = 50
events_out_of_order_policy               = "Adjust"
output_error_policy                      = "Drop"
streaming_units                          = 3
start_mode                               = "JobStartTime"
shared_access_policy_name                = "RootManageSharedAccessKey"
eventhub_names = {
  "dataresourceevent"         = "global__aixs_foundation.v1.domain.events.data.dataresourceevent"
  "aiexecutioncompletedevent" = "global__aixs_foundation.v1.domain.events.status.aiexecutioncompletedevent"
  "aiexecutionfailedevent"    = "global__aixs_foundation.v1.domain.events.status.aiexecutionfailedevent"
  "aiexecutionstartedevent"   = "global__aixs_foundation.v1.domain.events.status.aiexecutionstartedevent"
}
