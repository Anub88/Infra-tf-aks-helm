data "azurerm_client_config" "current_user" {
}

resource "azurerm_key_vault" "kv" {
  name                          = "kv-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = false
  tenant_id                     = data.azurerm_client_config.current_user.tenant_id
  soft_delete_retention_days    = var.kv_config.soft_delete_days
  purge_protection_enabled      = var.kv_config.purge_protection
  sku_name                      = var.kv_config.sku
  tags                          = var.tags
  public_network_access_enabled = var.kv_config.public_network_access_enabled
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current_user.tenant_id
  object_id    = data.azurerm_client_config.current_user.object_id
  key_permissions = [
    "Get", "List", "Update", "Create", "Delete", "Recover"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover"
  ]
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Delete", "Recover",
    "ListIssuers", "GetIssuers"
  ]
}

resource "azurerm_private_endpoint" "kv_private_endpoint" {
  name                = "pvtcnt-${azurerm_key_vault.kv.name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.kv_subnet_id

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
  private_service_connection {
    name                           = "svccnt-${azurerm_key_vault.kv.name}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
  tags = var.tags

}

#### alerts ####

resource "azurerm_monitor_activity_log_alert" "kv_alert_admin" {
  name                = "administrative-alert-kv-activity-log-alert"
  resource_group_name = var.resource_group_name

  scopes = [
    azurerm_key_vault.kv.id,
  ]

  criteria {
    category = "Administrative"
  }

  action {
    action_group_id = var.action_group_id
  }
  tags = var.tags
}

resource "azurerm_monitor_activity_log_alert" "kv_alert_health" {
  name                = "resourcehealth-alert-kv-activity-log-alert"
  resource_group_name = var.resource_group_name

  scopes = [
    azurerm_key_vault.kv.id,
  ]

  criteria {
    category = "ResourceHealth"
  }

  action {
    action_group_id = var.action_group_id
  }
  tags = var.tags
}

#### NSG ####

resource "azurerm_network_security_group" "keyvault_nsg" {
  name                = "nsg-kv-${var.ml_workspace_short_code}-${var.app_env}-${var.region_code}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.kv_subnet_id
  network_security_group_id = azurerm_network_security_group.keyvault_nsg.id
}



resource "azurerm_monitor_metric_alert" "static_metric_alert" {
  for_each            = var.kv_static_alert_rules
  name                = "${azurerm_key_vault.kv.name}-${each.value.name}"
  description         = each.value.description
  enabled             = each.value.enabled
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.kv.id]
  frequency           = each.value.frequency
  window_size         = each.value.window_size
  dynamic "criteria" {
    for_each = lookup(each.value,"static_criteria",{})
    content {
      aggregation      = lookup(criteria.value,"aggregation" )
      metric_name      = lookup(criteria.value,"metric_name" )
      metric_namespace = lookup(criteria.value,"metric_namespace" )
      operator         = lookup(criteria.value,"operator" )
      threshold        = lookup(criteria.value,"threshold" )
    }
  }
  action {
    action_group_id = var.action_group_id
  }
  tags = var.tags
}
resource "azurerm_monitor_metric_alert" "dynamic_metric_alert" {
  for_each            = var.kv_dynamic_alert_rules
  name                = "${azurerm_key_vault.kv.name}-${each.value.name}"
  description         = each.value.description
  enabled             = each.value.enabled
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.kv.id]
  frequency           = each.value.frequency
  window_size         = each.value.window_size
  dynamic "dynamic_criteria" {
    for_each = lookup(each.value,"dynamic_criteria",{})
    content {
      aggregation       = lookup(dynamic_criteria.value,"aggregation" )
      alert_sensitivity = lookup(dynamic_criteria.value,"alert_sensitivity" )
      metric_name       = lookup(dynamic_criteria.value,"metric_name" )
      metric_namespace  = lookup(dynamic_criteria.value,"metric_namespace" )
      operator          = lookup(dynamic_criteria.value,"operator" )
    }
  }
  action {
    action_group_id = var.action_group_id
  }
  tags = var.tags
}