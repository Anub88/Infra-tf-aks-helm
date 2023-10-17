# Auxiliary infrastructure pipelines

This folder contains pipelines that are used to run one-off operations on infrastructure and configuration.

These are:
* `mlware-global-infra-create-passwords`: To create ACR passwords for an external account to use a repository (i.e use-case).
* `mlware-global-infra-initialize-tfbackend`: To initialize all necessary resources for a terraform backend.
* `mlware-remove-basiccare-resources`: To remove basiccare resources from the platform state.
* `mlware-global-infra-create-acr-repo`: To create a repository inside azure container registry.

Please add these pipelines in Azure Devops Pipelines UI under an auxiliary folder so that they are separated from the ones that are used for normal development operations.