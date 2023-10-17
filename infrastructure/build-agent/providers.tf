terraform {
  # Set the terraform required version
  required_version = ">= 1.0.0"

  # Register common providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }


  }

}

# Configure the Azure Provider
provider "azurerm" {
  # skip_provider_registration = true
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = false
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }
  }
}
# Data

# Provides client_id, tenant_id, subscription_id and object_id variables

