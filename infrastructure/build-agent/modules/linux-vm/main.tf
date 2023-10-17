resource "azurerm_network_security_group" "build_agent_main_nsg" {
  name                = "nsg-${var.vm_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags

}
resource "azurerm_network_interface_security_group_association" "build_agent_main_isga" {
  network_interface_id      = azurerm_network_interface.build_agent_main_nic.id
  network_security_group_id = azurerm_network_security_group.build_agent_main_nsg.id

  lifecycle {
    ignore_changes = [network_interface_id, network_security_group_id]
  }
}

resource "azurerm_network_interface" "build_agent_main_nic" {
  name                = "nic-${var.vm_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "build_agent_main_vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  size                            = var.vm_config.size
  admin_username                  = var.vm_config.admin_username
  admin_password                  = random_password.password.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.build_agent_main_nic.id,
  ]

  identity {
    type = var.vm_config.identity_type

  }
  os_disk {
    caching                = var.vm_config.caching
    storage_account_type   = var.vm_config.storage_account_type
    disk_size_gb           = var.vm_config.disk_size_gb
    disk_encryption_set_id = azurerm_disk_encryption_set.disk_encryption_set.id
  }

  source_image_reference {
    publisher = var.vm_config.publisher
    offer     = var.vm_config.offer
    sku       = var.vm_config.sku
    version   = var.vm_config.version
  }
  tags = merge(var.tags, {})

}

resource "azurerm_backup_protected_vm" "build_agent_main_vm_backup" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  source_vm_id        = azurerm_linux_virtual_machine.build_agent_main_vm.id
  backup_policy_id    = var.backup_policy_id
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "kv-${var.vm_name}"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
  tags         = var.tags
}
resource "azurerm_key_vault_key" "disk_enc_key" {
  name         = "kv-${var.vm_name}-key"
  key_opts     = ["encrypt", "decrypt","sign","verify","wrapKey","unwrapKey"]
  key_type     = "RSA"
  key_size     = 2048
  key_vault_id = var.key_vault_id
  tags         = var.tags

}

resource "azurerm_disk_encryption_set" "disk_encryption_set" {
  key_vault_key_id    = azurerm_key_vault_key.disk_enc_key.id
  location            = var.resource_group_location
  name                = "des-${var.vm_name}"
  resource_group_name = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
  tags            = var.tags
}
resource "azurerm_key_vault_access_policy" "disk-encryption" {
  key_vault_id = var.key_vault_id
  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify",
    "List",
    "Update",
    "Create"
  ]
  secret_permissions = [
    "get",
    "list",
  ]


  tenant_id = azurerm_disk_encryption_set.disk_encryption_set.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.disk_encryption_set.identity.0.principal_id
}
resource "azurerm_role_assignment" "disk-encryption-read-keyvault" {
  scope                = var.key_vault_id
  role_definition_name = "Reader"
  principal_id         = azurerm_disk_encryption_set.disk_encryption_set.identity.0.principal_id
}

