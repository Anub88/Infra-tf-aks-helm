# Overview
The business continuity and disaster recovery (BCDR) concepts describe plans and actions to react on.

## RTO and RPO Requirements

- RTO = Recovery Time Objective - outage time allowed
- RPO = Recovery Point Objective - data loss allowed

## Thread Model

## Affected Resources

- Azure ML Workspace: managed by Microsoft
- Azure Storage: Blob, Cosmos DB
- Azure Key Vault
- Azure Container Registry
- Azure Compute Instance (ML, Managed Resources), Virtual Machines: managed by Microsoft
- Azure Compute Cluster (ML, Managed Resources), Virtual Machines: managed by Microsoft
- Azure Application Insights
- Azure Kubernetes Services
- Azure Functions

## Recovery Plan

- Geo-replication: storage
- Multi-regional Azure resource setup: primary, secondary regions, failover