provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.67.0"
    }
  }
}

locals {
  common_tags = {
    ContactEmailAddress = "chand.basha@zeiss.com,abhinay.patel@zeiss.com"
    application         = "CZMED-AIXS"
    department          = "dbu-ai"
    env                 = "${var.app_env}"
  }
  resource_group_name = "rg-mlw-${var.app_env}-${var.region_code}"
}

data "azurerm_kubernetes_cluster" "aks" {
 name = "aks-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-01"
 resource_group_name = "rg-mlw-${var.app_env}-${var.region_code}" 
}

data "azurerm_subnet" "snet_aks" {
  name                 = "snet-${var.ml_inf_short_code}-${var.app_env}-aks"
  virtual_network_name = "vnet-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name  = local.resource_group_name
}
## Cluster Compute Provisioning
resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = {
    for key, value in var.aks_node_pools : key => value
    if value["required"]
  }
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id
  name                  = each.key
  vnet_subnet_id        = data.azurerm_subnet.snet_aks.id

  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_type               = each.value.os_type
  node_labels           = each.value.node_labels
  tags                  = local.common_tags
  orchestrator_version  = try(each.value.orchestrator_version, data.azurerm_kubernetes_cluster.aks.kubernetes_version)
}

### MongoDB collection creation for Settings-service

data "azurerm_cosmosdb_account" "cosmos_account" {
  name                = "aixs-cosmodb-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = local.resource_group_name
}
  
data "azurerm_cosmosdb_mongo_database" "cosmosmongdb" {
  name                = "aixs-cosmodb-mogodb-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = local.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmos_account.name
}


resource "azurerm_cosmosdb_mongo_collection" "cosmosdb_mongo_collection" {
  for_each = toset(var.usecase_id)

  account_name           = data.azurerm_cosmosdb_account.cosmos_account.name
  database_name          = data.azurerm_cosmosdb_mongo_database.cosmosmongdb.name
  name                   = "${each.key }"
  resource_group_name    = local.resource_group_name
  shard_key              = "value.name"
  throughput             = 400
  index {
    keys   = ["_id"]
    unique = true
  }

}

resource "azurerm_cosmosdb_mongo_collection" "cosmosdb_mongo_collection_archive" {
  for_each = toset(var.usecase_id)
  
  account_name           = data.azurerm_cosmosdb_account.cosmos_account.name
  database_name          = data.azurerm_cosmosdb_mongo_database.cosmosmongdb.name
  name                   = "${each.key }_archive"
  resource_group_name    = local.resource_group_name
  shard_key              = "value.name"
  throughput             = 400
  index {
    keys   = ["_id"]
    unique = true
  }

}


## APIM api Import

data azurerm_api_management "apim" {
  name = "apim-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = local.resource_group_name
}


resource "azurerm_api_management_api" "apimapi" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["required"]
  }
  name                = each.key
  resource_group_name = local.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  revision            = "1"
  display_name        = each.key
  path                = each.value.backend == false ? "" : each.key
  service_url         = each.value.backend_url
  protocols           = ["https"]

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/${each.value.api_spec}")
  }

  oauth2_authorization {
    authorization_server_name = "apim_auth-${var.ml_api_short_code}-${var.app_env}-${var.region_code}"
  }

}
