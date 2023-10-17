# Configure the Azure Provider
provider "azurerm" {
  # skip_provider_registration = true
  features {}
}

terraform {
  backend "azurerm" {}
  # Set the terraform required version
  required_version = ">= 1.0.0"
  # Register common providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.38.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

data "azurerm_resource_group" "resource_group" {
  name = "rg-${var.project_name}-${var.app_env}-${var.region_code}"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-01"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_key_vault" "key_vault" {
  name                = "kv-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

module "helm-releases" {
  source                 = "./helm-releases"
  aks_kube_config        = data.azurerm_kubernetes_cluster.aks.kube_config.0
  resource_group_name    = data.azurerm_resource_group.resource_group.name
  subscription_id        = var.subscription_id
  ml_workspace_short_code= var.ml_workspace_short_code
  ml_inf_short_code      = var.ml_inf_short_code
  region_code            = var.region_code
  app_env                = var.app_env
  key_vault_id           = data.azurerm_key_vault.key_vault.id
  key_vault_name         = data.azurerm_key_vault.key_vault.name
  linux_node_pool        = var.linux_node_pool
  hdp_base_domain        = var.hdp_base_domain
  hdp_auth_domain        = var.hdp_auth_domain
  zeissid_api_domain     = var.zeissid_api_domain
  kubernetes_services    = var.kubernetes_services
}
