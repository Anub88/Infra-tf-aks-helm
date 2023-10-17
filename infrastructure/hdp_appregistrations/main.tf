provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.6.0"
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

data "azurerm_key_vault" "data_kv" {
  name                = "kv-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = local.resource_group_name
}

data "azuread_client_config" "current" {}

module "appreg_aixs" {
  source                   = "./appreg_aixs"
  appreg_aixs_app_owners   = var.appreg_aixs_app_owners
  app_env                  = var.app_env
  current_tenant_object_id = data.azuread_client_config.current.object_id
  current_tenant_id        = data.azuread_client_config.current.tenant_id
  key_vault_id             = data.azurerm_key_vault.data_kv.id
  region_code              = var.region_code
  tags                     = local.common_tags
}

module "appreg_usecase" {
  for_each                 = toset(var.usecases)
  source                   = "./appreg_usecase"
  usecase                  = each.key
  appreg_aixs_app_owners   = var.appreg_aixs_app_owners
  app_env                  = var.app_env
  current_tenant_object_id = data.azuread_client_config.current.object_id
  current_tenant_id        = data.azuread_client_config.current.tenant_id
  key_vault_id             = data.azurerm_key_vault.data_kv.id
  region_code              = var.region_code
  tags                     = local.common_tags
}