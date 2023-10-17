[[_TOC_]]

# Overview
This section comprises basic conventions and concepts of DevOps approach applied for the technical solution. The conventions mentioned here take into account that the Azure DevOps project this solution is part of is a shared DevOps project with many other initiaties having access to source control and build and deployment pipelines, and even build agents.

## Git Respositories

### One repository approach
The MLware solution uses a single git repository to organize all relevant (MLware-internal) artifacts like:
- Infrastructure as Code specifications
- Azure DevOps pipeline specifications
- Application code specifications
- Documentation
- Quality assurance and testing specifications
- Reporting

The approach of having a single git repository for MLware solution contains the following advantages:
- All in one place accessibility
- Information is complete and self-contained in one repository 

### Repository naming convention
The git repository is named acoording to the platform name:

``mlware-platform``

## Azure DevOps Pipelines
Since the Azure DevOps project is a shared one (shared with other initiatives), the Azure DevOps pipelines need to be prefixed. All Azure DevOps pipelines are always specified in code and are put under source control.

### Split of CI and CD
As a general concept, the CI and CD parts of our pipelines should be split. That way, it is easier to understand the pipelines for a new team member onboarding. Furthermore, it gives the flexibility to run one pipeline without running the other.
It also releases pipeline dependencies.

### Pipelines naming
The Azure DevOps pipelines are always prefixed with ```mlware`` to reflect the link to MLware platform solution, no matter which process for MLware solution is automated.

#### Convention

Furthermore, the Azure DevOps pipelines need to comply with the following naming convention:
``mlware-<infer or train>-<automation-category>-<sub-automation-purpose>``

- mlware = reflects the link to the overall MLware platform solution
- infer or train = specifying, if this is an automation pipeline for ***inference*** (= infer) or ***training*** (=train)
- automation-category = describes the category of automation
- sub-automation-purpose (optional) = this enables to classify the category of automation even in a more fine-grained way, when necessary

#### Automation category
The automation category is referring to the class of automation task. This could be:
- infra = infrastructure deployment (e. g. provisioning and changing cloud infrastructure)
- app = application build and deployment (e. g. building application artifacts and deploying applications onto cloud infrastructure, see ``infra``)
- qa = quality assurance automation (if not already covered by ``infra`` and ``app`` pipelines)

#### Sub automation purpose
If an automation category has been selected, this category needs (in general) be specified with more structural information. The following example addresses the MLware platform requirements for Azure DevOps pipeline naming, see [system overview](../../Architecture-and-Design/ML-BasicCare-ODx-Solution-Design.md) for details.

Inference:

1. mlware-infer-infra:
    - -api = infrastructure for api tier
    - -execute = infrastructure for AI model execution tier (including persistence)
    - -orchestrate = infrastructure for AI model inference execution
    - -ingest = infrastructure for data ingestion for inference
    - -workspace = infrastructure for AI model artifact management and cross-cutting concerns (monitoring, secrets management)
2. mlware-infer-app: 
    - -model-discovery
    - -model-mapping
    - -model-pre-processing
    - -platform-api

## Infrastructure as Code
All cloud infrastructure is to be provisioned by Infrastructure as Code (IaC) concept. The framework used in MLware context is [Terraform](https://www.terraform.io/).
For more inforamtion see Infrastructure -> Terraform

### Modularization
The infrastructure specification (as [Terraform](https://www.terraform.io/)) is modularized using Terraform modules. The Terraform modules are designed according to the overall solution design (see subnets):

- api: MLware public API for external consumers
- execute: MLware inference execution infrastructure
- orchestrate: MLware orchestration component for ML inference
- ingest: MLware (data) ingestion infrastructure
- workspace: MLware cross-cutting concerns with respect to ML (e. g. model and data management)

### Tagging cloud assets
For easier maintenance, cloud assets are getting tagged with the following Azure resource tags (tagging strategy):

- function: ``<inference | training | ml-shared>`` (note: ml-shared is a shared Azure resource between inference and training, e. g. Azure ML Workspace)
- environment: ``<dev | test | qa | stage | prod>`` (environment type of the asset)
- application: ``<mlware-platform>`` (indicating the MLware platform)
- department: ``<dbu-ai>`` (department owning the Azure resource from an operational perspective, here: Digital Business Unit AI)
- version: ``<1 | .. | n>`` (increasing number indicating the version of the Azure resource)
- bizcritical: ``<low | moderate | high | business unit-cricital>`` (business criticality is highlighting how business is impacted if a specific Azure resource is unavailable)
- dataclass: ``<low | moderate | high>`` (dataclass is indicating the data classification requiring specific data security and protection means)

### Azure Function Configuration - Python/Linux

Properly working Azure Functions require some app configurations to work w. Linux and Python:

- FUNCTIONS_WORKER_RUNTIME set 
- LinuxFxVersion set to python|3.9
- Application Stack -> python


