# Welcome to the terraform implementation of the MLware platform!

## Structure

The infrastructure is implemented in modules that you can find under the `modules` folder. In this folder resides the following two kinds of modules:
### Modules grouping azure resources necessary for a main resource to be deployed
- `aks`: An azure kubernetes cluster
- `cosmos_db`: Azure Cosmos DB provisoned with private endpoint
- `container_registry`: An azure container registry
- `function_app`: An azure function module
- `key-vault`: An azure key-vault
- `logging`: Sets up the infrastructure for logging
- `virtual-machine`: A virtual machine for hosting the build agent
- `vnet`: Creates a vnet

### Modules grouping those main resources together in one component
- `automation`: This module combines all resources required for an automation pipeline (CICD).
- `ml-inference-api`: Empty for now. Will combine an event grid topic with API access and an Azure Function resource with API access.
- `ml-inference-compute`: Combines the `aks` and `cosmosdb` modules. Exposes Azure kubernetes with Cosmos DB using a Private connection. The ComsosDB enables a private endpoint, which is hosted behind the virtual network and subnet. The comsos DB and AKS connection has been established and verified by using Curl -v from AKS.
- `ml-inference-ingestion`: Creates an event grid topic.
- `ml-training`: Empty for now.
- `ml-workflow-engine`: Empty for now. Should combine an azure function for the data-model mapping and an azure function for the model lookup.
- `ml-workspace-hub`: Combines an azure keyvault and the azure container registry.
- `networking`: Creates 2 vnets: one for inference and one for the workspace.
