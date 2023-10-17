resource "azurerm_api_management_custom_domain" "api_customdomain" {
  api_management_id = var.apimgmnt_id

  gateway {
    host_name    = "${var.app_env}-aixs.zeiss.com"
    key_vault_id = var.kv_certificate_id
  }

  developer_portal {
    host_name    = "${var.app_env}-aixs-devl.zeiss.com"
    key_vault_id = var.kv_certificate_id
  }

  management {
    host_name    = "${var.app_env}-aixs-mgmt.zeiss.com"
    key_vault_id = var.kv_certificate_id
  }
}
