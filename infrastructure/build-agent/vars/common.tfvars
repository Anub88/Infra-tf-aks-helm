#TODO to be changed
pat = ""

linux_vm_config = {
  size                            = "Standard_D2s_v3"
  admin_username                  = "vmadmin"
  disable_password_authentication = false
  caching                         = "ReadWrite"
  storage_account_type            = "Premium_LRS"
  disk_size_gb                    = 512
  publisher                       = "Canonical"
  offer                           = "0001-com-ubuntu-server-focal"
  sku                             = "20_04-lts-gen2"
  version                         = "latest"
  identity_type                   = "SystemAssigned"

}

location    = "West US 2"
region_code = "weus"
pool        = "HDP Image Analyzer Application Agent"
url         = "https://dev.azure.com/ZEISSgroup-MED"
kv_config = {
  soft_delete_days = "7"
  purge_protection = "true"
  sku              = "standard"

}

public_acr_repos        = ["oct_image_analyzer", "bsi","aixs-usecase-maringa"]
ml_workspace_short_code = "mlws"
acr_config = {
  sku                           = "Premium"
  public_network_access_enabled = false
  pip_allocation_method         = "Static"
  pip_sku                       = "Standard"

}

log_analytics_workspace_initial = "lws-mlif"
email_address                   = "chand.basha@zeiss.com"
vm_monitor_metric_alerts = [
  {
    name             = "cpu-alert"
    description      = "High CPU usage alert"
    severity         = 3
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
    frequency        = "PT1M"
    window_size      = "PT5M"

  },
  {
    name             = "memory-alert"
    description      = "High Memory usage alert"
    severity         = 3
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 20
    frequency        = "PT1M"
    window_size      = "PT5M"

  }
]

enable_alert                   = true

vm_metric_log = {
  category                 = "AllMetrics"
  enabled                  = true
  retention_policy_enabled = true
  retention_policy_days    = 90
}