locals {
  aksname                                = "aks-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-01"
  aks_subnet_id                          = lookup(var.vnet_subnets_name_id, "snet-${var.ml_inf_short_code}-${var.app_env}-aks")
  network_watcher_default_resource_group = "NetworkWatcherRG"
  private_dns_zone_name                  = join(".", slice(split(".", azurerm_kubernetes_cluster.aks.private_fqdn), 1, length(split(".", azurerm_kubernetes_cluster.aks.private_fqdn))))
  private_dns_zone_id                    = "${var.current_tenant_id}/resourceGroups/${azurerm_kubernetes_cluster.aks.node_resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}"
  # Rules for AKS NSG. TODO: Rules will be worked on w. Zeiss Security
  nsgrules = {
    rdp = {
      name                       = "rdp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
  }
}

#TODO: AD integartion need to enabled based on the other projects security implemenations
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = local.aksname
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  dns_prefix              = "dns-${local.aksname}"
  private_cluster_enabled = var.aks_config.private_cluster_enabled
  kubernetes_version      = var.aks_config.kubernetes_version
  #495392 Activate policy addon
  azure_policy_enabled       = true
  local_account_disabled     = false
  enable_pod_security_policy = false
  default_node_pool {
    name           = var.aks_config.name
    node_count     = var.aks_config.node_count
    vnet_subnet_id = local.aks_subnet_id
    vm_size        = var.aks_config.vm_size
    kubelet_config {
      pod_max_pid           = var.pod_max_pid
      cpu_cfs_quota_enabled = true
    }

  }
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
  #495392  Link AKS with Azure Defender
  microsoft_defender {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
  identity {
    type = "SystemAssigned"
  }
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "10m"
  }
  tags = var.tags
}

resource "azurerm_role_assignment" "aks_subnet_rbac" {
  scope                = local.aks_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = {
    for key, value in var.aks_node_pools : key => value
    if value["required"]
  }
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.key
  vnet_subnet_id        = local.aks_subnet_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_type               = each.value.os_type
  tags                  = var.tags
  orchestrator_version  = var.aks_config.kubernetes_version
  dynamic "kubelet_config" {
    for_each = each.value["os_type"] == "Linux" ? [1] : []
    content {
      pod_max_pid           = var.pod_max_pid
      cpu_cfs_quota_enabled = true
    }
  }
}

resource "azurerm_role_assignment" "aks_acr_pull_role" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}
##  if the resource is delete, terrafrom will not clean up the dapr addon.It needs to be manually remove
data "external" "aks_dapr_extension" {
  program = ["/usr/bin/bash", "${path.module}/scripts/check_dapr_extension.sh"]
  query = {
    resource_group_name = var.resource_group_name
    aks_name            = azurerm_kubernetes_cluster.aks.name
  }
}


resource "null_resource" "dapr-provision" {
  provisioner "local-exec" {
    command = <<EOT
    az config set extension.use_dynamic_install=yes_without_prompt
    az extension add --name k8s-extension
    az k8s-extension list --resource-group ${var.resource_group_name} --cluster-name ${azurerm_kubernetes_cluster.aks.name} --cluster-type managedClusters >extensions.log  || exit 1
    installed=$(jq '.[]| .scope.cluster.releaseNamespace == "dapr-system"' extensions.log) || exit 1
    echo $installed
    if [ X"$installed" = X"true" ] ; then
     if [ X"${var.dapr_update}" = X"true" ]; then
      echo "updating dapr-extension"
      az k8s-extension update --cluster-type managedClusters --cluster-name ${azurerm_kubernetes_cluster.aks.name} \
       --resource-group ${var.resource_group_name} \
       --name daprExtension \
       --auto-upgrade-minor-version false \
       --version ${var.dapr_version} \
       --release-train stable \
       --configuration-settings "${var.dapr_config_settings}" >response.log || exit 1
      echo "dapr updated with status $(jq '.| .provisioningState' response.log) and has version $(jq '.| .version' response.log)" || exit 1
     else
       echo "dapr already installed with status $(jq '.[]| .provisioningState' extensions.log) and has version $(jq '.[]| .version' extensions.log)"
     fi
    else
     echo "installing dapr-extension"
     az config set extension.use_dynamic_install=yes_without_prompt
     az extension add --name k8s-extension
     az k8s-extension create --cluster-type managedClusters --cluster-name ${azurerm_kubernetes_cluster.aks.name} \
       --resource-group ${var.resource_group_name} \
       --name daprExtension \
       --extension-type Microsoft.Dapr \
       --auto-upgrade-minor-version false \
       --version ${var.dapr_version} \
       --release-train stable \
       --configuration-settings "${var.dapr_config_settings}" >response.log || exit 1
     echo "dapr installed with status $(jq '.| .provisioningState' response.log) and version $(jq '.| .version' response.log)"
    fi

 EOT
  }
  triggers = {
    aks_cluster          = azurerm_kubernetes_cluster.aks.id,
    dapr_enabled         = data.external.aks_dapr_extension.result["dapr_installed"]
    dapr_version         = var.dapr_version
    dapr_config_settings = var.dapr_config_settings
    dapr_update          = var.dapr_update
  }
}


# Azure says "do not modify the NIC-level network security group managed by AKS. Instead, create more subnet-level network security groups to modify the flow of traffic"
# https://learn.microsoft.com/en-us/azure/aks/concepts-security#azure-network-security-groups
# => So we create our own NSG for AKS here
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "nsg-aks-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}



# Associate it with the subnet AKS sits in 
resource "azurerm_subnet_network_security_group_association" "aks_nsg_association" {
  subnet_id                 = local.aks_subnet_id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}



# Add rules to it
resource "azurerm_network_security_rule" "rules" {
  for_each                    = local.nsgrules
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# Need a storage account to store the nsg flow logs
resource "azurerm_storage_account" "nsg_flowlog_storage" {
  name                      = "stflowlog${var.ml_inf_short_code}${var.app_env}${var.region_code}"
  resource_group_name       = var.resource_group_name
  location                  = var.resource_group_location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  tags                      = var.tags
}

# Setup flow logs
resource "azurerm_network_watcher_flow_log" "aks_flow_logs" {
  #  TODO: we should rename the location shortcode so it reflects the 
  #  shortcode Azure uses for default naming
  network_watcher_name      = "NetworkWatcher_westus2"
  resource_group_name       = local.network_watcher_default_resource_group
  name                      = "nsg-flowlog-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
  storage_account_id        = azurerm_storage_account.nsg_flowlog_storage.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = var.flow_log_retention_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_workspace_id
    workspace_region      = var.resource_group_location
    workspace_resource_id = var.log_analytics_workspace_id
    interval_in_minutes   = 10
  }
  tags = var.tags
}



# Setup diagnostic settings.
data "azurerm_monitor_diagnostic_categories" "ds_aks_categories" {
  resource_id = azurerm_kubernetes_cluster.aks.id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting_aks" {
  name                       = "diagnostic-logs-${var.ml_inf_short_code}-${var.app_env}"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_aks_categories.log_category_types)

    content {
      category = log.value
      enabled  = true
    }
  }

  #574765 Configure a metrics logger
  dynamic "metric" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.ds_aks_categories.metrics)

    content {
      category = metric.value
      enabled  = true
    }
  }
}
