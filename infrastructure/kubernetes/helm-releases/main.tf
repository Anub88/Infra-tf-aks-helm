# Configure helm provider.
provider "helm" {
  kubernetes {
    host                   = var.aks_kube_config.host
    client_certificate     = base64decode(var.aks_kube_config.client_certificate)
    client_key             = base64decode(var.aks_kube_config.client_key)
    cluster_ca_certificate = base64decode(var.aks_kube_config.cluster_ca_certificate)
  }
  experiments {
    manifest = true
  }
}

locals {
  core_services_ns              = "core-services-ns"
  core_hdp_observer_name        = "core-hdp-observer"
  core_planner_name             = "core-planner"
  core_manager_name             = "core-manager"
  ai_manager_name               = "ai-manager"
  data_proxy_ns                 = "data-proxy-ns"
  hdp_base_proxy_name           = "hdp-base-proxy"
  hdp_auth_proxy_name           = "hdp-auth-proxy"
  zeissid_api_proxy_name        = "zeissid-api-proxy"

  usecase_maringa_connector_ns  = "usecase-${var.kubernetes_services["usecase_maringa_model"].name}-connector-ns"
  usecase_maringa_connector_name      = "usecase-${var.kubernetes_services["usecase_maringa_model"].name}-connector"
  usecase_maringa_configuration_name  = "usecase-${var.kubernetes_services["usecase_maringa_model"].name}-configuration"

  usecase_maringa_model_ns      = "usecase-${var.kubernetes_services["usecase_maringa_model"].name}-model-ns"
  usecase_maringa_model_name     = "usecase-${var.kubernetes_services["usecase_maringa_model"].name}-model"

  usecase_odx_model_ns      = "usecase-${var.kubernetes_services["usecase_odx_model"].name}-model-ns"
  usecase_odx_model_name     = "usecase-${var.kubernetes_services["usecase_odx_model"].name}-model"

  eventhub_namespace_name       = "eventhub-namespace-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
  eventhub_storage_acc_name     = "eventhubst${var.ml_inf_short_code}${var.app_env}${var.region_code}"
  eventhub_storage_con_name     = "eventhub-namespace-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}-container"

  dapr_aixs_secret_store_name   = "aixs-keyvault"
  acr_name                      = "acrmlws${var.app_env}weus.azurecr.io" 

}

# Secret Configuration for hdp-observer Helm Charts.
data "azuread_client_config" "current" {}

data "azurerm_key_vault_secret" "config_client_app_id_secret" {
  name         = "hdp-client-hdp-client-app-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "config_secret_id_secret" {
  name         = "hdp-client-hdp-secret"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "config_api_app_id_secret" {
  name         = "hdp-client-hdp-api-app-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "config_subscription_key_secret" {
  name         = "hdp-client-hdp-subscription-key"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "config_target_tenant_id_secret" {
  name         = "hdp-client-hdp-target-tenant-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "dapr_app_registration_password_secret" {
  name         = "app-reg-dapr-client-secret-${var.ml_inf_short_code}-${var.region_code}-${var.app_env}"
  key_vault_id = var.key_vault_id
}
data "azuread_application" "dapr_app_registration" {
  display_name = "app-reg-dapr-${var.ml_inf_short_code}-${var.app_env}-${var.region_code}"
}

resource "helm_release" "core_hdp_observer" {
  name              = local.core_hdp_observer_name
  chart             = "${path.module}/charts/core-hdp-observer"
  namespace         = local.core_services_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/core-hdp-observer/values.yaml")}",
  ]
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["core_hdp_observer"].replica_count
  }
  set {
    name  = "tag"
    value =  var.kubernetes_services["core_hdp_observer"].tag
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "env.ENV_STATE"
    value =  var.app_env
  }
  set {
    name  = "envSecrets.CONFIG_TENANT_ID"
    value = data.azuread_client_config.current.tenant_id
  }
  set {
    name  = "envSecrets.CONFIG_CLIENT_APP_ID"
    value = data.azurerm_key_vault_secret.config_client_app_id_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_SECRET_ID"
    value = data.azurerm_key_vault_secret.config_secret_id_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_API_APP_ID"
    value = data.azurerm_key_vault_secret.config_api_app_id_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_SUBSCRIPTION_KEY"
    value = data.azurerm_key_vault_secret.config_subscription_key_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_TARGET_TENANT_ID"
    value = data.azurerm_key_vault_secret.config_target_tenant_id_secret.value
  }
  set {
    name  = "env.CONFIG_HDP_BASE_ADDRESS"
    value = "https://${var.hdp_base_domain}/api"
  }
  # DAPR - Secrets
  set {
    name  = "daprSecrets.azureClientSecret"
    value = data.azurerm_key_vault_secret.dapr_app_registration_password_secret.value
  }
  set {
    name  = "daprSecrets.azureClientId"
    value = data.azuread_application.dapr_app_registration.application_id
  }
  set {
    name  = "daprSecrets.azureTenantId"
    value = data.azuread_client_config.current.tenant_id
  }
  # DAPR - Key Vault Component
  set {
    name  = "daprVariables.vaultName"
    value = var.key_vault_name
  }
  # DAPR - PubSub Component
  set {
    name  = "daprVariables.subscriptionID"
    value = var.subscription_id
  }
  set {
    name  = "daprVariables.resourceGroupName"
    value = var.resource_group_name
  }
  set {
    name  = "daprVariables.eventHubNamespace"
    value = local.eventhub_namespace_name
  }
  set {
    name  = "daprVariables.storageAccountName"
    value = local.eventhub_storage_acc_name
  }
  set {
    name  = "daprVariables.storageContainerName"
    value = local.eventhub_storage_con_name
  }
}

# Secret Configuration for planner Helm Charts.

data "azurerm_key_vault_secret" "CONFIG_HDP_AUTH_CLIENT_secret" {
  name         = "hdp-client-hdp-auth-client"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_AUTH_USERNAME_secret" {
  name         = "hdp-client-hdp-auth-username"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_AUTH_PWD_secret" {
  name         = "hdp-client-hdp-auth-pwd"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_AZURE_CLIENT_APP_ID" {
  name         = "azure-client-app-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_AZURE_TENANT_ID" {
  name         = "azure-tenant-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "appreg-aixs-s2s-hdp-client-secret-dev-weus" {
  name         = "appreg-aixs-s2s-hdp-client-secret-dev-weus"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "appreg-aixs-s2s-hdp-client-id-dev-weus" {
  name         = "appreg-aixs-s2s-hdp-client-id-dev-weus"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_SUBSCRIPTION_KEY_DEV_PLANNER" {
  name         = "hdp-subscription-key-dev-planner"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_SUBSCRIPTION_KEY" {
  name         = "hdp-client-hdp-subscription-key"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "CONFIG_SUBSCRIPTION_KEY_secret" {
  name         = "hdp-client-hdp-subscription-key"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_API_APP_ID" {
  name         = "hdp-api-app-id"
  key_vault_id = var.key_vault_id
}
data "azurerm_key_vault_secret" "CONFIG_HDP_TENANT_ID" {
  name         = "hdp-tenant-id"
  key_vault_id = var.key_vault_id
}
#data "azurerm_key_vault_secret" "hdp-api-app-id" {
#  name         = "hdp-api-app-id"
#  key_vault_id = var.key_vault_id
#}
#data "azurerm_key_vault_secret" "CONFIG_APPREG_AIXS_S2S_HDP_CLIENT_ID_DEV_WEUS" {
#  name         = "appreg-aixs-s2s-hdp-client-id-dev-weus"
#  key_vault_id = var.key_vault_id
#}
data "azurerm_key_vault_secret" "CONFIG_AZURE_SECRET" {
  name         = "appreg-aixs-s2s-hdp-client-secret-dev-weus"
  key_vault_id = var.key_vault_id
}

resource "helm_release" "core_planner" {
  name      = local.core_planner_name
  chart     = "${path.module}/charts/core-planner"
  namespace = var.core_services_ns
  values = [
    "${file("${path.module}/charts/core-planner/values.yaml")}",
  ]
  set {
    name  = "tag"
    value = var.kubernetes_services["core_planner"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["core_planner"].replica_count 
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "env.ENV_STATE"
    value =  var.app_env
  }
  set {
    name  = "aixsSecretStoreName"
    value = local.dapr_aixs_secret_store_name
  }
  set {
    name  = "envSecrets.CONFIG_AZURE_TENANT_ID"
    value = data.azurerm_key_vault_secret.azure-tenant-id.value
  }
  set {
    name  = "envSecrets.CONFIG_AZURE_CLIENT_APP_ID"
    value = data.azurerm_key_vault_secret.azure-client-app-id.value
  }
  set {
  name  = "envSecrets.CONFIG_SUBSCRIPTION_KEY"
  value = data.azurerm_key_vault_secret.config_subscription_key_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_HDP_AUTH_CLIENT"
    value = data.azurerm_key_vault_secret.config_hdp_auth_client_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_HDP_AUTH_USERNAME"
    value = data.azurerm_key_vault_secret.config_hdp_auth_username_secret.value
  }
  set {
    name  = "envSecrets.CONFIG_HDP_AUTH_PWD"
    value = data.azurerm_key_vault_secret.config_hdp_auth_pwd_secret.value
  }
  
  set {
    name  = "envSecrets.CONFIG_APPREG_AIXS_S2S_HDP_CLIENT_ID_DEV_WEUS"
    value = data.azurerm_key_vault_secret.appreg-aixs-s2s-hdp-client-id-dev-weus.value
  }
  set {
    name  = "envSecrets.CONFIG_AZURE_SECRET"
    value = data.azurerm_key_vault_secret.appreg-aixs-s2s-hdp-client-secret-dev-weus.value
  }
   set {
    name  = "envSecrets.CONFIG_HDP_TENANT_ID"
    value = data.azurerm_key_vault_secret.hdp-tenant-id.value
  }
  set {
    name  = "envSecrets.CONFIG_HDP_SUBSCRIPTION_KEY"
    value = data.azurerm_key_vault_secret.hdp-client-hdp-subscription-key.value
  }
  set {
    name  = "envSecrets.CONFIG_HDP_API_APP_ID"
    value = data.azurerm_key_vault_secret.hdp-api-app-id.value
  }
  ####This if for new s2s
  set {
    name  = "envSecrets.CONFIG_HDP_SUBSCRIPTION_KEY_DEV_PLANNER"
    value = data.azurerm_key_vault_secret.hdp-subscription-key-dev-planner.value
  }
  ############################################################
  set {
    name  = "env.CONFIG_HDP_BASE_URL"
    value = "https://${var.hdp_base_domain}/api"
  }
  set {
    name  = "env.CONFIG_HDP_DEVICE_AUTH_TOKEN_URL"
    value = "https://${var.zeissid_api_domain}/V1.0/Device/Authentication/AcquireToken/"
  }
  set {
    name  = "env.CONFIG_HDP_AUTH_TOKEN_URL"
    value = "https://${var.hdp_auth_domain}/OAuth/oauth2/v2.0/token?p=B2C_1A_ZeissIdRopcSignIn"
  }
  depends_on = [
    helm_release.core_hdp_observer
  ]
}

resource "helm_release" "core_manager" {
  name      = local.core_manager_name
  timeout =  local.helm_release_timeout
  chart     = "${path.module}/charts/core-manager"
  namespace = local.core_services_ns
  values = [
    "${file("${path.module}/charts/core-manager/values.yaml")}",
  ]
  set {
    name  = "tag"
    value = var.kubernetes_services["core_manager"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["core_manager"].replica_count 
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "tag"
    value = var.kubernetes_services["core_manager"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["core_manager"].replica_count 
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "env.ENV_STATE"
    value =  var.app_env
  }
  depends_on = [
    helm_release.core_hdp_observer
  ]
}

resource "helm_release" "hdp_base_proxy" {
  name              = local.hdp_base_proxy_name
  chart             = "${path.module}/charts/data-proxy/bitnami-nginx"
  namespace         = local.data_proxy_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/data-proxy/values-base.yaml")}"
  ]
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "hdpBaseDomain"
    value = var.hdp_base_domain
  }
}

resource "helm_release" "hdp_auth_proxy" {
  name              = local.hdp_auth_proxy_name
  chart             = "${path.module}/charts/data-proxy/bitnami-nginx"
  namespace         = local.data_proxy_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/data-proxy/values-auth.yaml")}"
  ]
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "hdpAuthDomain"
    value = var.hdp_auth_domain
  }
}

resource "helm_release" "zeissid_api_proxy" {
  name              = local.zeissid_api_proxy_name
  chart             = "${path.module}/charts/data-proxy/bitnami-nginx"
  namespace         = local.data_proxy_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/data-proxy/values-zeissid.yaml")}"
  ]
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "zeissIdApiDomain"
    value = var.zeissid_api_domain
  }
}


resource "helm_release" "usecase_maringa_connector" {
  name              = local.usecase_maringa_connector_name
  chart             = "${path.module}/charts/usecase-connector"
  namespace         = local.usecase_maringa_connector_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/usecase-connector/values.yaml")}",
  ]
  set {
    name  = "tag"
    value = var.kubernetes_services["usecase_maringa_connector"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["usecase_maringa_connector"].replica_count 
  }
  set {
    name  = "fullnameOverride"
    value = local.usecase_maringa_connector_name
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "env.ENV_STATE"
    value =  var.app_env
  }
  set {
    name  = "aixsSecretStoreName"
    value = local.dapr_aixs_secret_store_name
  }
  set {
    name  = "env.CONFIG_AI_APPLICATION_ID"
    value = "84f93c84-a4e9-44ec-b87c-49d8817d3876"
  } 
  set {
    name  = "env.CONFIG_SUPERVISOR_RUN_ENDPOINT"
    value = "http://${local.usecase_maringa_model_name}-{index}.${local.usecase_maringa_model_name}.${local.usecase_maringa_model_ns}.svc.cluster.local:8000/api/v1/run"
  }
  set {
    name  = "env.CONFIG_SUPERVISOR_READY_ENDPOINT"
    value = "http://${local.usecase_maringa_model_name}-{index}.${local.usecase_maringa_model_name}.${local.usecase_maringa_model_ns}.svc.cluster.local:8000/api/v1/ready"
  }  
  set {
    name  = "env.CONFIG_SUPERVISOR_RUN_TIMEOUT"
    value = "60"
  }
  set {
    name  = "env.CONFIG_SUPERVISOR_READY_TIMEOUT"
    value = "60"
  }
  set {
    name  = "env.CONFIG_POD_NAME"
    value = "pod/${local.usecase_maringa_model_name}-0"
  }
  set {
    name  = "env.CONFIG_PORT"
    value = "8000"
  }
  # DAPR - Secrets
  set {
    name  = "daprSecrets.azureClientSecret"
    value = data.azurerm_key_vault_secret.dapr_app_registration_password_secret.value
  }
  set {
    name  = "daprSecrets.azureClientId"
    value = data.azuread_application.dapr_app_registration.application_id
  }
  set {
    name  = "daprSecrets.azureTenantId"
    value = data.azuread_client_config.current.tenant_id
  }
  # DAPR - Key Vault Component
  set {
    name  = "daprVariables.vaultName"
    value = var.key_vault_name
  }
  # DAPR - PubSub Component
  set {
    name  = "daprVariables.subscriptionID"
    value = var.subscription_id
  }
  set {
    name  = "daprVariables.resourceGroupName"
    value = var.resource_group_name
  }
  set {
    name  = "daprVariables.eventHubNamespace"
    value = local.eventhub_namespace_name
  }
  set {
    name  = "daprVariables.storageAccountName"
    value = local.eventhub_storage_acc_name
  }
  set {
    name  = "daprVariables.storageContainerName"
    value = local.eventhub_storage_con_name
  }
}


resource "helm_release" "usecase_maringa_configuration" {
  name      = local.usecase_maringa_configuration_name
  chart     = "${path.module}/charts/usecase-configuration"
  namespace         = local.usecase_maringa_connector_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/usecase-configuration/values.yaml")}",
  ]
  set {
    name  = "tag"
    value = var.kubernetes_services["usecase_configuration"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["usecase_configuration"].replica_count 
  }
  set {
    name  = "usecaseName"
    value =  var.kubernetes_services["usecase_maringa_model"].name
  }
  set {
    name  = "fullnameOverride"
    value = local.usecase_maringa_configuration_name
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "env.ENV_STATE"
    value =  var.app_env
  }
  depends_on = [
    helm_release.core_planner
  ]
}

# Secret Configuration for usecase model Helm Charts.
data "azurerm_key_vault_secret" "config_device_subscription_key_secret" {
  name         = "hdp-client-hdp-device-subscription-key"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "config_app_id" {
  name         = "hdp-client-hdp-app-id"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "config_hdp_auth_pwd_usecase_secret" {
  name         = "hdp-client-hdp-auth-password-usecase"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "config_hdp_auth_username_usecase_secret" {
  name         = "hdp-client-hdp-auth-username-usecase"
  key_vault_id = var.key_vault_id
}

resource "helm_release" "usecase_maringa_model" {
  name              = local.usecase_maringa_model_name
  chart             = "${path.module}/charts/usecase-model"
  namespace         = local.usecase_maringa_model_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/usecase-model/maringa-values.yaml")}",
  ]
  set {
    name  = "usecaseTag"
    value = var.kubernetes_services["usecase_maringa_model"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["usecase_maringa_model"].replica_count 
  }
  set {
    name  = "usecaseName"
    value = var.kubernetes_services["usecase_maringa_model"].name
  }
  set {
    name  = "fullnameOverride"
    value = local.usecase_maringa_model_name
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = var.linux_node_pool
  }
  set {
    name  = "usecaseServicePort"
    value = "8888"
  }
  set {
    name  = "usecaseEnviromentVariables.ZEISS_TOKEN_URL" # zeissid-api-proxy.data-proxy-ns.svc.cluster.local
    value = "http://${local.zeissid_api_proxy_name}.${local.data_proxy_ns}.svc.cluster.local/V1.0/Device/Authentication/AcquireToken/" 
  }
  set {
    name  = "usecaseEnviromentVariables.ZEISS_HDP_URL" # zeissid-api-proxy.data-proxy-ns.svc.cluster.local
    value = "http://${local.hdp_base_proxy_name}.${local.data_proxy_ns}.svc.cluster.local/api/dicom/studies" 
  }
  set { 
    name  = "usecaseEnviromentVariables.DUMMYMODEL"
    value = "TRUE"
  }
  set {
    name  = "usecaseEnviromentSecrets.ZEISS_USERNAME"
    value = data.azurerm_key_vault_secret.config_hdp_auth_username_usecase_secret.value
  }
  set {
    name  = "usecaseEnviromentSecrets.ZEISS_PASSWORD"
    value = data.azurerm_key_vault_secret.config_hdp_auth_pwd_usecase_secret.value
  }
  set { 
    name  = "usecaseEnviromentVariables.ZEISS_APP_ID"
    value = data.azurerm_key_vault_secret.config_app_id.value
  }
  set {
    name  = "usecaseEnviromentVariables.ZEISS_SUBSCRIPTION_KEY"
    value = data.azurerm_key_vault_secret.config_subscription_key_secret.value
  }
  set {
    name  = "usecaseEnviromentVariables.ZEISS_DEVICE_SUBSCRIPTION_KEY"
    value = data.azurerm_key_vault_secret.config_device_subscription_key_secret.value
  }
  set {
    name  = "usecaseEnviromentVariables.ENV_STATE"
    value =  var.app_env
  }
  set {
    name  = "supervisor.tag"
    value = var.kubernetes_services["usecase_supervisor"].tag 
  }
  set {
    name  = "supervisor.enviromentVariables.CONFIG_AI_APPLICATION_RUN_ENDPOINT"
    value = "http://localhost:8888/api/v1/execute"
  }
  set {
    name  = "supervisor.enviromentVariables.CONFIG_AI_APPLICATION_TIMEOUT"
    value = "60"
  }
  set {
    name  = "supervisor.enviromentVariables.CONFIG_STORAGE_ROOT_PATH"
    value = "/cache/"
  }
  set {
    name  = "supervisor.enviromentVariables.CONFIG_ENVIRONMENT"
    value =  var.app_env
  }
  set {
    name  = "supervisor.enviromentVariables.ENV_STATE"
    value =  var.app_env
  }
}

# ODX
data "azurerm_key_vault_secret" "config_odx_servicebus_connectionstring" {
  name         = "odx-servicebus-connectionstring"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "config_odx_tablestorage_connectionstring" {
  name         = "odx-tablestorage-connectionstring"
  key_vault_id = var.key_vault_id
}


resource "helm_release" "usecase_odx_model" {
  name              = local.usecase_odx_model_name
  chart             = "${path.module}/charts/usecase-model"
  namespace         = local.usecase_odx_model_ns
  create_namespace  = true
  values = [
    "${file("${path.module}/charts/usecase-model/odx-values.yaml")}",
  ]
  set {
    name  = "usecaseTag"
    value = var.kubernetes_services["usecase_odx_model"].tag 
  }
  set {
    name  = "replicaCount"
    value = var.kubernetes_services["usecase_odx_model"].replica_count 
  }
  set {
    name  = "usecaseName"
    value = var.kubernetes_services["usecase_odx_model"].name
  }
  set {
    name  = "fullnameOverride"
    value = local.usecase_odx_model_name
  }
  set {
    name  = "registry"
    value = local.acr_name
  }
  set {
    name  = "agentpool"
    value = "wincpu"
  }
  set {
    name  = "usecaseServicePort"
    value = "80"
  }
  set {
    name  = "dapr.metadata.connectionString"
    value = data.azurerm_key_vault_secret.config_odx_servicebus_connectionstring.value
  }
  set {
    name  = "usecaseEnviromentVariables.TableConnectionString"
    value = data.azurerm_key_vault_secret.config_odx_tablestorage_connectionstring.value
  }
}

## ai-manager

data "azurerm_key_vault_secret" "cosmos_password" {
  name         = "cosmos-mongodb-rw-password"
  key_vault_id = var.key_vault_id
}

resource "helm_release" "ai_manager" {
  name      = local.ai_manager_name
  chart     = "${path.module}/charts/ai-manager"
  namespace = local.core_services_ns
  values = [
    "${file("${path.module}/charts/ai-manager/${var.app_env}-values.yaml")}"
  ]
  set {
    name  = "tag"
    value = var.kubernetes_services["ai_manager"].tag 
  }
  set {
    name  = "secret.cosmospassword"
    value = data.azurerm_key_vault_secret.cosmos_password.value
  }  
  
}