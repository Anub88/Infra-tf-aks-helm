#!/bin/bash
# We need to login like this since we need to be authenticated as either user or pass credentials from the service connection.
# The latter is not possible since we don't create the secret manually and therefore injecting it is not obvious.
az login

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_key_vault_key.kv_key

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_key_vault_secret.integration_test_secret_key_vault

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_log_analytics_storage_insights.tablestorage

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_log_analytics_workspace.tablestorage

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_private_endpoint.tablestorage_private_endpoint

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_storage_account.tablesa

terraform state rm module.ml_inference_compute.module.tablestorage.azurerm_storage_table.tablestorage

terraform state rm module.ml_inference_compute.module.tablestorage.random_id.st_account