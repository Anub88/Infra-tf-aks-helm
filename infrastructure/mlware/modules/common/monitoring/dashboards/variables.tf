
variable "region" {
    type        = string
    description = "Region for Azure Dashboard JSON / TPL"
}

variable "app_env" {
    type        = string
    description = "Application Environment"
}

variable "resource_group_name" {
    type        = string
    description = "Associated Resource Group for the Azure Dashbaord"
}

variable "location" {
  type        = string
  description = "Associated Location for the Azure Dashbaord"
}

variable "tags" {
  type        = map(string)
  description = "Region for Dashboard JSON"
}

variable "eventhub_name" {
  type = string
  description = "Eventhub Namespace - Name"
}

variable "eventhub_id" {
  type = string
  description = "Eventhub Namespace - ID"
}

variable "kubernetes_name" {
  type = string
  description = "AKS (Kubernetes Cluster) - Name"
}

variable "kubernetes_id" {
  type = string
  description = "AKS (Kubernetes Cluster) - ID"
}

variable "log_analytics_workspace_id" {
  type = string
  description = "Log Analytics Workspace - ID"
}
