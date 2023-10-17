variable "aks_kube_config" {
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
    username               = string
    password               = string
  })
  sensitive = true
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "subscription_id" {
  type        = string
  description = "azure subscription id from environment"
}

variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "ml_inf_short_code" {
  type        = string
  description = "Ml Inference name. Use only lowercase letters and numbers"
}

variable "ml_workspace_short_code" {
  type        = string
  description = "Ml Workspace name. Use only lowercase letters and numbers"
}

variable "hdp_base_domain" {
  type        = string
  description = "HDP base domain / URL"
}

variable "hdp_auth_domain" {
  type        = string
  description = "HDP base domain / URL"
}

variable "zeissid_api_domain" {
  type        = string
  description = "Zeiss ID Api domain / URL"
}

variable "linux_node_pool" {
  type        = string
  description = "linux nodepool name"
}

variable "key_vault_id" {
  type = string
  description = "key vault id for secrets"
}

variable "key_vault_name" {
  type = string
  description = "key vault name for secrets"
}

variable "kubernetes_services" {
  type = map(object({
    tag: string
    replica_count: number
    name: string
  }))
}