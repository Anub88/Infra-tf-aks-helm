## Overview
This section comprises details about IAM (Identity and Access Management) including the handling of the lifecycle of identities.

## Role-Based Access Control
The access to MLware solution infrastructure, resources, and entities is per default handled by RBAC (role-based access control). For this purpose the [roles and actors](#Domain-Roles-and-Actors) are mapped onto specific Azure cloud roles implementing access to Azure cloud resources and infrastruture as well as application and data resources.

## Lifecycle Management
Azure Access Review process (Identity Governance) is to be used to support regularly revisting granted access rights to users. 

## Domain Roles and Actors
The following domain roles and responsibilities exist in the context of MLware solution and platform.

### AI Product Customer
The AI Product Customer is a consumer of MLware services and features. The AI Product Customer provides, in general, its own product solution (in form of a service) requiring to integrate the AI offer of MLware. This is, in general, a service-to-service integration.   

### AI Product Manager
The AI Product Manager is owning the overall AI product solution from business perspective in an end-to-end manner. The AI Product Manager is handling release approvals within the bigger medical and regulatory context. 

### AI SQA Responsible
The AI SQA Responsible represents the software quality assurance role responsible for end-to-end and larger system testing, on a business use case level.

### AI Regulatory Affairs Responsible
The AI Regulatory Affairs Responsible is ensuring that regulatory and medical requirements are implemented as stated. The AI Regulatory Affairs Responsible is handling the strategy for covering regulatory concerns in conceptual and development phase.

### AI Scientist
The AI Scientist represents the machine learning expert creating AI model artifacts and is mainly involved in AI model training phases. The AI Scientist is responsible for tracking the quality of AI model artifacts.

### AI DevOps Engineer
The AI DevOps Engineer is responsible for specifying and provisioning the (cloud) infrastructure for AI models and AI processing. The AI DevOps Engineer owns the automation pipelines for provisiong infrastructure in a deterministic and efficient way.

### AI Security Engineer
The AI Security Engineer covers the responsibility of specifying and maintaining the security artifacts of the cloud infrastructure and is a specialized DevOps Engineer.

### AI Application Engineer
The AI Application Engineer is responsible for creating application-level implementation solutions for MLware platform.

## Cloud Roles
The existing domain roles need to be mapped and implemented using specific cloud roles.


| Domain Role | Cloud Role | Description |
|--|--|--|
| AI Product Customer | API User Reader, Cosmos DB Container-Level Reader | The AI Product Customer interacts with the MLware backend through web APIs and retrieves data from MLware persistence (inference results). |
| AI Product Manager | API User Reader, Cosmos DB Container-Level Reader, Azure DevOps Product Owner | The AI Product Manager interacts with the MLware backend through web APIs and retrieves data from MLware persistence (inference results). |
| AI SQA Responsible | API User Reader, Cosmos DB Container-Level Reader | The AI SQA Responsible interacts with the MLware backend through web APIs and retrieves data from MLware persistence (inference results). |
| AI Regulatory Affairs Responsible | API User Reader, Cosmos DB Container-Level Reader | The AI Regulatory Affairs Responsible interacts with the MLware backend through web APIs and retrieves data from MLware persistence (inference results). |
| AI Scientist | ML Workspace Contributor, Blob Storage Contributor (Data Management) | The AI Scientist is involved in training-phase AI model creation. |
| AI DevOps Engineer | Application Insights Owner, Key Vault Contributor, Cosmos DB Operator, AKS Owner, Event Grid Contributor, Storage Account Contributor, Functions Contributor, Azure DevOps Contributor | The AI DevOps Engineer is responsible for specifying and provisioning the cloud infrastructure. |
| AI Security Engineer | VNet Owner, Application Gateway Owner, Firewall Owner | The AI Security Engineer is responsible for specifying and provisioning the security cloud infrastructure. This is a specialized DevOps Engineering role. |
| AI Application Engineer | Azure Functions Contributor, Azure DevOps Contributor | The AI Application Engineer needs to be enabled to contribute application-level implementations and provision application-level artifacts on the (existing) cloud infrastructure. |


