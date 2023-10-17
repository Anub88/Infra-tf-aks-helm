locals {
  snet_names = ["snet-${var.ml_workspace_short_code}-${var.app_env}-cloudservice",
    "snet-${var.ml_workspace_short_code}-${var.app_env}-storage",
    "snet-${var.ml_workspace_short_code}-${var.app_env}-vm",
  "snet-${var.ml_workspace_short_code}-${var.app_env}-mlws",
    "snet-${var.ml_workspace_short_code}-${var.app_env}-cosmodb"]
  vnet_name   = "vnet-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  snet_ranges = cidrsubnets(element(var.cidr_space, 0), 8, 8, 8, 8,8)
  snet_inf_names = ["snet-${var.ml_inf_short_code}-${var.app_env}-aks",
    "snet-${var.ml_api_short_code}-${var.app_env}-cloudservice",
    "snet-${var.ml_api_short_code}-${var.app_env}-agic",
    "snet-${var.ml_inf_short_code}-${var.app_env}-broker",
    "snet-${var.ml_ingestion_short_code}-${var.app_env}-cloudservice",
  "snet-${var.ml_ingestion_short_code}-${var.app_env}-apim",
    "snet-${var.ml_inf_short_code}-${var.app_env}-redis"
    ]
  vnet_inf_name   = "vnet-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  snet_inf_ranges = cidrsubnets(element(var.cidr_mlinf, 0), 5, 8, 8, 8, 8, 5, 8)
}

module "vnet" {
  source                  = "./vnet"
  vnet_name               = local.vnet_name
  vnet_location           = var.vnet_location
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  address_space           = var.cidr_space
  subnet_prefixes         = local.snet_ranges
  subnet_names            = local.snet_names
  subnet_service_endpoints = {
    element(local.snet_names, 0) = ["Microsoft.KeyVault", "Microsoft.ContainerRegistry"],
    element(local.snet_names, 1) = ["Microsoft.Storage"],
    element(local.snet_names, 4) = ["Microsoft.AzureCosmosDB"],
  }

  subnet_enforce_private_link_endpoint_network_policies = {
    element(local.snet_names, 0) = false
  }
  tags = var.tags
}

module "vnet_inf" {
  source                  = "./vnet"
  vnet_name               = local.vnet_inf_name
  vnet_location           = var.vnet_location
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  address_space           = var.cidr_mlinf
  subnet_prefixes         = local.snet_inf_ranges
  subnet_names            = local.snet_inf_names
  subnet_service_endpoints = {
    element(local.snet_inf_names, 2) = ["Microsoft.EventHub", "Microsoft.Web"],
    element(local.snet_inf_names, 4) = ["Microsoft.Web"],
    element(local.snet_inf_names, 5) = ["Microsoft.EventHub", "Microsoft.Web"]
  }
  tags = var.tags
}

## vnet peering from mlws to mlinf

module "peer_mlws_mlinf" {
  source                       = "./peering"
  virtual_network_peering_name = "peer-${local.vnet_name}-${module.vnet_inf.vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = module.vnet.vnet_name
  remote_virtual_network_id    = module.vnet_inf.vnet_id
  tags                         = var.tags
}

## vnet peering from mlinf to mlws

module "peer_mlinf_mlws" {
  source                       = "./peering"
  virtual_network_peering_name = "peer-${local.vnet_inf_name}-${module.vnet.vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = module.vnet_inf.vnet_name
  remote_virtual_network_id    = module.vnet.vnet_id
  tags                         = var.tags
}

## vnet peering from mlws to build agent vnet

module "peer_mlws_ba" {
  source                       = "./peering"
  virtual_network_peering_name = "ba-peer-${local.vnet_name}-${var.buildagent_vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = module.vnet.vnet_name
  remote_virtual_network_id    = var.buildagent_vnet_id
  tags                         = var.tags
}

## vnet peering from mlinf to build agent vnet
module "peer_mlinf_ba" {
  source                       = "./peering"
  virtual_network_peering_name = "ba-peer-${local.vnet_inf_name}-${var.buildagent_vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = module.vnet_inf.vnet_name
  remote_virtual_network_id    = var.buildagent_vnet_id
  tags                         = var.tags
}

## peering from  build agent vnet to mlws
module "peer_ba_mlws" {
  source                       = "./peering"
  virtual_network_peering_name = "ba-peer-${local.vnet_name}-${var.buildagent_vnet_name}"
  resource_group_name          = var.buildagent_rg_name
  virtual_network_name         = var.buildagent_vnet_name
  remote_virtual_network_id    = module.vnet.vnet_id
  tags                         = var.tags
}

## peering from  build agent vnet to mlinf
module "peer_ba_mlinf" {
  source                       = "./peering"
  virtual_network_peering_name = "ba-peer-${local.vnet_inf_name}-${var.buildagent_vnet_name}"
  resource_group_name          = var.buildagent_rg_name
  virtual_network_name         = var.buildagent_vnet_name
  remote_virtual_network_id    = module.vnet_inf.vnet_id
  tags                         = var.tags
}

## PrivateLink Config
## The private zones are created once in the "shared" terraform. The links are created for each environment.
module "private_dns_link" {
  source                  = "./private-dns"
  for_each                = toset(var.dns_names)
  private_dns_zone        = each.key
  resource_group_name     = var.resource_group_name
  dns_resource_group_name = var.shared_resource_group_name
  vnet_ids = {
    "vnet_ws" = {
      vnet_name = module.vnet.vnet_name
      vnet_id   = module.vnet.vnet_id
    }
    "vnet_inf" = {
      vnet_name = module.vnet_inf.vnet_name
      vnet_id   = module.vnet_inf.vnet_id
    }
  }
  tags = var.tags
}
