#!/bin/bash
# We need to login like this since we need to be authenticated as either user or pass credentials from the service connection.
# The latter is not possible since we don't create the secret manually and therefore injecting it is not obvious.
az login

terraform import -var-file=vars/common.tfvars -var-file=vars/qa-mlw-weus.tfvars module.logging.azurerm_log_analytics_solution.log_analytics_sentinel /subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlw-qa-weus/providers/Microsoft.OperationsManagement/solutions/SecurityInsights\(lws-mlif-qa-weus-aks\)

terraform import -var-file=vars/common.tfvars -var-file=vars/qa-mlw-weus.tfvars module.monitoring_app_insights.azurerm_security_center_contact.mdc_contact /subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/providers/Microsoft.Security/securityContacts/default1