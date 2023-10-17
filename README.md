# Introduction 
This is the repository for all MLware platform artifacts, including infrastructure as code, application source code, documentation, which belongs to the concern and responsibility of MLware.

[![Build Status](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_apis/build/status/Image%20Analyzer%20App-Pipelines/mlware-inference/applications/mlware-infer-app-orchestration-engine-func-dev?branchName=develop&label=Orchestrator-Dev)](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_build/latest?definitionId=1497&branchName=develop)
[![Build Status](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_apis/build/status/Image%20Analyzer%20App-Pipelines/mlware-inference/applications/mlware-infer-app-lookup-func-dev?branchName=develop&label=Lookup-Dev)](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_build/latest?definitionId=1496&branchName=develop)
[![Build Status](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_apis/build/status/Image%20Analyzer%20App-Pipelines/mlware-inference/applications/mlware-infer-app-service-storage-access-func-dev?branchName=381755_fix_deployed_functions&label=StorageAccess-Dev)](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_build/latest?definitionId=1485&branchName=381755_fix_deployed_functions)

# Getting Started

The ***mlware-platform*** repository has the following structure:
1. application: The application directory is organized around separate functional concerns, which are per default encapsulated as (micro)services and are individually deployable from application and persistence perspective.
2. documentation: this directory comprises solution-level documentation (solution design, concepts, conventions)
3. infrastructure: this directory comprises infrastructure as code (cloud infrastructure) specifications for different environments
    - build-agent: this directory has the terraform deployment code for the build agents
    - apimgmt: this directory comprises the terraform deployment code for the API Management related resources.
    - shared: this directory comprises the terraform deployment code for resources that are to be deployed once per subscription (e.g DNS Names).
    - mlware: this directory comprises the terraform deployment code for the mlware platform
        - modules: this directory contains all tensorflow modules, separated in common, inference and training concerns
    - kubernetes: contains all cluster related configuration and components, plus the deployment charts for the different services.
    - More information about Terraform [here](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/9419/Terraform).
4. deployment: this directory comprises automation pipelines (build and deployment pipelines) and kubernetes deployment files
    - azure-pipelines: this folder contains all azure pipelines
    - kubernetes: this folder contains all kubernetes deployment files


In general, each of these folder contains an inference directory, a training directory and a common or global directory:
## Inference directory
The inference directory comprises all components related to ML inference, according to the solution design.

## Training directory
The training directory contains all ML training components, according to the solution design.

## Common/Global directory
in the common or gloabl directory are the components used for global purposes, such as the build agent deployment or the mlware infrastructure deployment.