[[_TOC_]]


Terraform is a tool for managing _infrastructure as code (IaC)_. Here are some details on how to use/change/apply terraform code for the current project. Terraform is used to describe the infrastructure of the application in this project.

# Folder structure
In each folder under the project folder _infrastructure_, there are folders containing isolated concepts. Each of these has independent state files (see the section below for further information on state files). There is one folder and therefore one state file for the following concepts:
- apimgmt: The resources for our API management tool from azure is defined there. This component is separated from the rest since it contains external dependencies (SSL certificate that needs to be given by the CIT team for instance).
- build-agent: Our self-hosted build agents are defined in this folder. Since there is one build agent per subscription (the same build agent used for DEV and QA for instance), those resources are separated.
- shared: Some resources can be deployed only once per Azure subscription, such as DNS names. For that reason, those resources have their own state file.
- mlware: All other resources of the AIXS infrastructure is defined in this folder.

## Modules
In the AIXS project, the terraform code is structured using modules. A module is a resource collection. A module can contain other modules as well. 

### MLWare modules
In the `mlware` folder, the resources are modularized based on the [AIXS architecture](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8818/ML-Overall-Solution-Design). For instance, the azure key vault and the private ACR are in the ML Workspace subnet in the architecture. For that reason, you'll find the `container-registry` and `key-vault` modules in the `ml-workspace-hub` folder. 

## The files 'main.tf', 'variables.tf' and 'output.tf'

Globally, in the AIXS terraform code, you can find the following files: 
- **main.tf** - here, either the resources are directly defined or a module is defined. To define a resource, you need to provide the correct syntax, including the name and passed parameters, see an [example for the API Management Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management).
You can define a module, which describes a collection of resources or other modules. A module is linked to a folder (over the parameter _source_), which contains again a main.tf, output.tf, and variables.tf. 
Modules allow grouping resources to keep an overview of all resources. For example, it makes sense to group the resources in one module, which belongs to the same subnet, as described in the [architecture plan](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8818/ML-Overall-Solution-Design).
- **output.tf** - the defined resources and their attributes (name, id, etc.) are available only in the current module. To make them available also outside the current module, define them as an output in the file output.tf.
- **variables.tf** - here, the variables used in the module (or in the root main.tf) are defined. In the file _common.tfvars_ in folder _vars_, the value of the defined variables is provided.

# Variable values
Variables values are specified in the `.tfvars` files located in the folder infrastructure/vars. However, some variables are defined in the pipeline directly in the `terraform` command call with the keyword `--var`. Those variables are concerned:

for app_env = "qa" or "dev":
- ml_inference_storage_account_name = "sttblcaa090"
- buildagent_rg        = "rg-cicd-weus-buildagent"
- buildagent_vnet_name = "vnet-cicd-weus-buildagent"
- shared_resource_group_name = "rg-mlws-shared-weus"

and for app_env = "stage":
- buildagent_rg        = "rg-cicd-stage-weus-buildagent"
- buildagent_vnet_name = "vnet-cicd-stage-weus-buildagent"
- shared_resource_group_name = "rg-mlws-shared-stage-weus"

# What is a state File and how are they used in AIXS?

In order to know what has been deployed previously in order to avoid deploying a resource again, terraform uses a so-called state file. It provides a description of the resources that have previously been deployed. The file needs to end with `.tfstate`. Based on the state of the latest deployment, a delta to the desired state (change in the code) is defined.

The state files of the AIXS project are stored in a Blob Storage. Since that resource can't be managed by terraform (otherwise, you end up in a vicious circle), a shell script (`init-tf-backend.sh`) can be executed using the Azure pipeline mlware-global-infra-initialize-tfbackend.yaml.

Read more on state files in [this wonderful blog article](https://itnext.io/how-and-when-to-ignore-lifecycle-changes-in-terraform-ed5bfb46e7ae). In particular, the article explains the usage of an _ignore_changes_ feature, which is also used in the current project. 

# Execution of Terraform

## Prerequisites
Before starting, make sure that:
- A service connection for the new environment exists (you can find them in azureDevOps under `Project settings`->`Pipelines`->`Service connections`. The name is `sp-iaa-<env>-tf-serviceconnection`. So for dev, it would be `sp-iaa-dev-tf-serviceconnection`. This service connection will enable you to create and modify resources. That service connection should be created with the _Azure Resource Manager_ and be allowed for the subscription and resource group you want to create your infrastructure in.
- The backend for terraform is initialized. In essence, a blob storage and container should have been created to be able to create the state file.

## Pipeline
To execute terraform and deploy the therein defined infrastructure on Azure, one pipeline (.yaml) is defined: mlware-infra-deployment-modular.yaml. It executes the following steps: 
1. Define Variables for environments
2. Terraform Initialize: Sets a connection up to the remote backend to be able to access and modify the state file, which is located in a blob storage
3. Terraform Validate: Makes sure that the code is valid (checks for references, file names, etc.)
3. Terraform Plan: Creates the plan for the resources to deploy in order to only modify the infrastructure in azure that has been modified in the code.
4. Terraform Apply: Use the plan created in the previous step to deploy the new resources and modify the existing one, which has changes in the code.

Note: to execute the entire pipeline, a manual approval prior to the execution of the deployment job is necessary. If you don't have the rights to approve, ask some of your colleagues to do so. 

## Execution order
In order to deploy a complete fresh environment, the terraform code should be executed in the following order, that respects the dependencies:

`build-agent (needs to run first) >> shared >> malware >> apim (needs to be run last)`

Execution order:

1. Run the tf backend init pipeline `mlware-global-infra-initialize-tfbackend` and select correct environment (see `Prerequisite section above`)
2. __Only if the new environment is in a new subscription__: 
    1. Run the build agent infrastructure with the pipeline `mlware-global-infra-buildagent-<env>.yaml` where `<env>` is equivalent to your new subscription.
    2. Setup the build agent as described in [this wiki page](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8851/Build-Agent)
    3. Run the shared terraform code with the pipeline `mlware-global-infra-deployment-shared.yaml`
5. Run the infrastructure terraform code with the pipeline `mlware-global-infra-deployment-<env>.yaml` where `<env>` is your new environment.
6. [Optional] Run API management if you want to give access to your API outside of the vnet. For that, use the pipeline `mlware-apim-infra-deployment-<env>.yaml` where `<env>` is your new environment.

## Troubleshooting

### 403 - Could not create an application

```
ApplicationsClient.BaseClient.Post(): unexpected status 403 with OData
error: Authorization_RequestDenied: Insufficient privileges to complete the
operation.

```

If you get a 403 from terraform, it might be that your app registration created automatically by the service connection has not to have enough permissions to read/write/delete resources. This can be changed by:

- Adding the managed application as owner of the subscription. The following command can be used: 

```
az role assignment create --role "Owner" --assignee-object-id "<object id of the entreprise application managed by the app registration>" --scope /subscriptions/<subscription name>
```
- Adding api permissions to the app registration. This can be done with:
```
az ad app permission add --id $APP_ID --api 00000002-0000-0000-c000-000000000000 --api-permissions 824c81eb-e3f8-4ee6-8f6d-de7f50d565b7=Role
az ad app permission add --id $APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope
az ad app permission add --id $APP_ID --api 00000003-0000-0000-c000-000000000000 --api-permissions 18a4783c-866b-4cc7-a460-3d5e5662c884=Role
```


where `$APP_ID` is the app id of the app registration. Those api permissions must be granted by an admin. Therefore, you can send an email to cit-cloudservices@zeiss.com. 

### 403 - Can't read from the key vault

If you get the following error message:

```
The user, group or application 'appid=***;oid=<some-object-id>;iss=https://sts.windows.net/<some-subscription-id>/' does not have secrets get permission on key vault '<your-keyvault-name>;location=westus2'.
```

it means that your service principal does not have enough permission to read from the key vault. You can add those manually:
- Go to the Azure portal
- Navigate to the key vault shown in the error
- Click on Access Policies on the left menu bar
- Create a new access policy for your service principal (just paste the object id from the error when the "principal" tab shows up).

# Coding Guidelines
Please make sure to read those instructions before starting to code.

### Usage of terraform primitives.
- Never use depends_on when it can be solved differently. 
In order to avoid surprises, make sure to always avoid using depends_on in your code, especially on a module level. You can find more information in this [awesome blog article](https://itnext.io/beware-of-depends-on-for-modules-it-might-bite-you-da4741caac70)
- **data**: This should be used only to query attributes of dynamic components or components that are outside of the managed state (i.e a global key-vault, etc).
- Always use **output**, **var** to pass values in between modules.

### Code organisation and inline comments.
- Always put your data sources on the root main: here again, if you want to understand why, you can read [this blog article](https://itnext.io/beware-of-depends-on-for-modules-it-might-bite-you-da4741caac70)
- In order to keep a clean code base, always create modules around your code. Therefore, the root `main.tf` will stay readable and it's just a better and reusable way to structure your code
- Follow the AIXS architecture to put your modules at the right place.
- When using a **data source**, comment information about the target resource that you are querying, for example: `# Query Key Vault in MLWare state`. This makes clear the usage of the data source and helps developers follow the dependency, make it clear and concise. 

# Resource organisation

![AzureResources.png](/.attachments/AzureResources-ac59a542-5963-450d-9197-009edfa5884f.png)

In resources of the _rg-backend-..._ several .state files are stored: 
- in _rg-backend-dev-..._, 3 state files are available: one for the mlware application (used to deploy rg-mlw-dev-weus), one for the api managment (used to deploy APIM) and one for the build agent (used to deploy rg-cicd-weus-buildagent).
-  in _rg-backend-qa-..._, 2 state files are available: one for the mlware application and one for the api managment.
-  in _rg-backend-dev-..._, 1 state file is available: for the mlware application.

