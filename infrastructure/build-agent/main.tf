data "azurerm_client_config" "current_user" {}

# The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26.
locals {
  linux_computer_name = "vm-buildagent"
  linuxvm             = "vm-${var.app_env}-buildagent"
  resource_group_name = "rg-${var.app_env}-${var.region_code}-buildagent"
  snet_names          = ["snet-${var.app_env}-vm-buildagent", "AzureBastionSubnet"]
  vnet_name           = "vnet-${var.app_env}-${var.region_code}-buildagent"
  snet_ranges         = cidrsubnets(element(var.cidr_space, 0), 8, 10)
  common_tags = {
    ContactEmailAddress = "chand.basha@zeiss.com,abhinay.patel@zeiss.com"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "key_vault" {
  source                  = "./modules/key-vault"
  app_env                 = var.app_env
  tenant_id               = data.azurerm_client_config.current_user.tenant_id
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  common_tags             = local.common_tags
  object_id               = data.azurerm_client_config.current_user.object_id
  kv_config               = var.kv_config
  linuxvm_name            = local.linuxvm
}

# Resources moved into key-vault module.
moved {
  from = random_password.password
  to   = module.key_vault.random_password.password
}

moved {
  from = azurerm_key_vault.kv
  to   = module.key_vault.azurerm_key_vault.kv
}

moved {
  from = azurerm_key_vault_secret.vmpassword
  to   = module.key_vault.azurerm_key_vault_secret.vmpassword
}
moved {
  from = azurerm_key_vault_access_policy.kv-policy
  to   = module.key_vault.azurerm_key_vault_access_policy.kv-policy
}


module "vnet" {
  source                  = "./modules/az-network"
  vnet_name               = local.vnet_name
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  address_space           = var.cidr_space
  subnet_prefixes         = local.snet_ranges
  subnet_names            = local.snet_names
  tags                    = local.common_tags
}



module "linuxvm" {
  source                  = "./modules/linux-vm"
  resource_group_name     = azurerm_resource_group.rg.name
  tags                    = local.common_tags
  vm_config               = var.linux_vm_config
  vm_name                 = local.linuxvm
  computer_name           = local.linux_computer_name
  app_env                 = var.app_env
  kv_config               = var.kv_config
  region_code             = var.region_code
  resource_group_location = azurerm_resource_group.rg.location
  subnet_id               = element(module.vnet.vnet_subnets, 0)
  key_vault_id            = module.key_vault.key_vault_id
  agent_name_linux        = "IAA-BuildAgent"
  pat                     = var.pat
  pool                    = var.pool
  url                     = var.url
  bootstrap_agent         = false
  backup_policy_id        = module.recovery_vault.backup_policy_id
  recovery_vault_name     = module.recovery_vault.recovery_vault_name
}

# Resources moved into the linuxvm module.
moved {
  from = azurerm_linux_virtual_machine.build_agent_vm
  to   = module.linuxvm.azurerm_linux_virtual_machine.build_agent_main_vm
}
moved {
  from = azurerm_backup_protected_vm.vm-linux-backup
  to   = module.linuxvm.azurerm_backup_protected_vm.build_agent_main_vm_backup
}
moved {
  from = azurerm_network_interface.build_agent_nic
  to   = module.linuxvm.azurerm_network_interface.build_agent_main_nic
}
moved {
  from = azurerm_network_security_group.nsg
  to   = module.linuxvm.azurerm_network_security_group.build_agent_main_nsg
}
moved {
  from = azurerm_network_interface_security_group_association.main
  to   = module.linuxvm.azurerm_network_interface_security_group_association.build_agent_main_isga
}


module "recovery_vault" {
  source                  = "./modules/recovery-vault"
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  app_env                 = var.app_env
  tags                    = local.common_tags
}
# Resources moved into recorvery_vault module.
moved {
  from = azurerm_backup_policy_vm.backup_policy
  to   = module.recovery_vault.azurerm_backup_policy_vm.backup_policy
}
moved {
  from = azurerm_recovery_services_vault.recovery_vault
  to   = module.recovery_vault.azurerm_recovery_services_vault.recovery_vault
}

data "azurerm_log_analytics_workspace" "law" {
  name                = "${var.log_analytics_workspace_initial}-${var.lws_env}-${var.region_code}"
  resource_group_name = "rg-mlw-${var.lws_env}-${var.region_code}"
}

module "acr_public" {
  source                     = "./modules/public-acr"
  acr_config                 = var.acr_config
  app_env                    = var.app_env
  ml_workspace_short_code    = var.ml_workspace_short_code
  region_code                = var.region_code
  tags                       = local.common_tags
  acr_repositories           = var.public_acr_repos
  resource_group_location    = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  count = var.app_env == "cicd-stage" ? 0:1
}


module "bastion_server" {
  source                  = "./modules/bastion-server"
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  bastion_subnet_id       = module.vnet.bastion_subnet_id
  app_env                 = var.app_env
  region_code             = var.region_code
  tags                    = local.common_tags
}

module "vm_monitoring" {
  source = "./modules/monitoring"
  app_env = var.app_env
  resource_group_name = azurerm_resource_group.rg.name
  tags = local.common_tags
  virtual_machine_ids = [module.linuxvm.build_agent_main_vm_id]
  virtual_machine_names = [module.linuxvm.build_agent_main_vm_name]
  vm_monitor_metric_alerts = var.vm_monitor_metric_alerts
  email_address = var.email_address
  enable_alert = var.enable_alert
  vm_metric_log = var.vm_metric_log
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
}