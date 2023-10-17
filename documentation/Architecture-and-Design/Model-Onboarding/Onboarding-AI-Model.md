# Overview
This section gives an overview of the artifacts and processes necessary to conduct automated AI model deployments, based on AI model artifacts provided by (3rd-party) AI model owners.

# Model Artifacts
The following AI model artifacts are necessary to be provided by model owners:
- An OCI-compliant image comprising an AI model including its runtime and runtime dependencies, integrating against a data access interface
- AI model metadata specification 
- An OpenAPI v3 AI model (web) API specification 
- Gold standard for validating the deployment of a model

## OCI-compliant image
The AI model is packaged as a self-contained OCI-compliant image comprising the AI model artifact as well as its complete runtime and dependencies. Moreover, the AI model artifacts needs to expose a web interface compliant with OpenAPI v3 specification, in **.yml** format: [model interface](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform?path=/documentation/Architecture-and-Design/.attachments/openapi_model_webapi.yml).
The MLware paltform concept for AI model deployments separates the concerns of AI model inference (responsibility of AI model owner) from data access (e. g. data access of inference data or persisting inference results; responsibility of MLware platform). Therefore, the AI model artifact needs to integrate against a [data access interface](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform?path=/documentation/Architecture-and-Design/.attachments/openapi_dataaccess_webapi.yml) (in **.yml** format).

## Model metadata specification
The MLware platform offers deployment capabilities for many AI models. Therefore, the AI models need to be maintained and distinguished with respect to capabilities. The MLware platform follows the concept of dynamic (during runtime) AI model discovery. For this purpose, AI models need to be registered, which is achieved via AI model metadata. In this context, a model owner needs to provide [model metadata](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform?path=/documentation/Architecture-and-Design/.attachments/inference_metadata_model.yml) in **.yml** format.

## Gold standard 
In order to validate a deployed AI model and conducting sanity checks, a gold standard for model inference needs to be provided by model owner.


# Provisioning and Deployment Processes
The model owner provisions the mentioned model artifacts in the following way:
- OCI-compliant container (OCI image): in Azure Container Registry - ACR URI tbd
- AI model metadata specification (.yml file): in git repository - Git-repo URI tbd
- OpenAPI v3 AI model API specification (.yml file): in git repository - Git-repo URI tbd

The deployment process picks up the provided artifacts, invoked by an event-trigger, and executes the deployment pipeline, for:
- Provisioning (changed) compute targets based on model metadata specification
- Deployment of (new) OCI image on (changed) compute targets