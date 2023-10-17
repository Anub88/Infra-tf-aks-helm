[[_TOC_]]

# Introduction

## Objective

The Objective of this document is to identify the overall approach of the Integration testing activities, features to be tested, and the testing tasks to be performed for the AIXS Platform. 

## Scope

The integration testing of the AIXS platform system will include Azure functions on applications and Azure Kubernetes Services, APIs, and Azure modules like Azure Key Vault, Azure Container Registry and Azure Table Storage.

## System Overview

The AIXS Platform is a Platform as a Service(PaaS) hosts the client AI algorithms and  trigger inference processing within MLware platform, saves inference results and these results are stored to Azure Storage accounts. These Historical inference results can be retrieved by client applications and view the results.

The aim of integration testing is to test the interfaces between the modules of AIXS platform and the Client application.

# Approach

## Assumptions/Constraints

- The first build of the Platform system was ready for system integration testing on August 16th 2022.
- Each build of the AIXS Platform will have passed unit and unit-to-unit testing before it is transferred to the system integration testing environment.
- Acceptance criteria for the testing requirements/specifications to be defined clearly and same to be signed off with testing team and stake holders prior testing activities.

## Coverage

Test coverage will be measured by

1. Test coverage by feature

A Software feature are the changes made in the system to add new functionality or modify the existing functionality.

2. Test coverage by use case

Use case covers a AIXS platform interaction with the client applications for different tasks. It is a sequence of steps describing platform and client interaction. Traceability metrics from test case to use case will help us identify the test coverage.
    
## Software components 

- AI Product Application 
- Azure Data Storage
- Azure Active Directory
- Azure Event Grid
- AI Model Orchestrator
- AI Model Registry
- AI Model Inference Creation in AKS Cluster
- AI Inference results storage in Azure Table Storage

## Requirements

All user requirements as specified in the Product Requirement Document(PRS) will be tested. 

## Test Tools

- All Integration tests are automated using Python BDD Framework.
[More about Integration Framework using BDD](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8476/ML-Quality-Assurance?anchor=integration-testing)
- Azure DevOps for testing activities - Integration Test cases are Implemented and available under Repos , Test Execution is performed through Pipeline automation and Test Execution status is available in the Dashboard.


|Test Activity| Source |
|--|--|
|Test case Implementation  | [Test cases as source code](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform?path=/application/inference/integration_tests&version=GBdevelop&_a=contents) |
|Test Execution  | [Integration Tests Pipeline](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_build?definitionScope=%5CAIXS-Pipelines%5Cmlware-inference%5Cintegration-tests) |
| Test Execution Results | [Dashboard](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/HDP%20-%20AI%20Execution%20Suite/_dashboards/dashboard/cc916cb8-7f08-4953-850e-5322750442f6) |

- Postman to validate the APIs - The MLware platform is exposing APIs to be consumed by AI product applications. 

How these APIs are consumed - Refer below.

[More about Inference APIs](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8468/External-Inference-API)

## Testing types:

The following types of testing will be performed during integration testing:
-  System Integration testing
- Regression testing, to ensure that a change to the system does not introduce new defects 
   
This is achieved through Pipeline automation . This is achieved through Pipeline automation - Azure Pipelines supports continuous integration (CI) and continuous delivery (CD) to continuously test,build and deploy the code.

Continuous integration (CI) automates tests and it also helps to catch bugs or issues early in the development cycle and Continuous delivery automatically deploys and tests code in multiple stages to help drive quality.

[Run AIXS Integration Tests Pipeline](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_build?definitionScope=%5CAIXS-Pipelines%5Cmlware-inference%5Cintegration-tests)

# Test Plan : 
The test plan gives breif details about Integration tests conducted, features to be tested, and the testing tasks to be carried on AIXS platform and AI Client application.

## Tasks and Deliverables

|Task|Start-Date  |  End-Date| Deliverables |
|--|--|--|--|
|Integration Tests Implementation  |16th Aug 2022  |  |  All Integration tests to be developed|
|System Integration Tests  |08th Sep 2022  |  |Integration with ODx to be working  |
|Test Execution  |  |  |  All Integration tests to be passed in the Pipeline|
| Train SQA Team (Self-learning, Classroom training, and peer programming) 	 |20th Sep 2022  |  | Testing team to work on Integration tests Independently |

## Team Reviews

The following reviews will be conducted during the Integration test phase.

-   Code review through PR 
-   Test plan review
-   Test case review
-   Test progress review

## Environment Details

All testing activities will be carried out in QA Environment only.

# Features/Components to be tested

## AI Production Application 

Following are the Azure functions implemented from the Product application for complete workflow orchestration to trigger the algorithm and retreieve the inference results.

### Service Data Mapping 
    
 - AI client application sends the request to execute the algorith through APIM instance -AI backend starts orchestration ML workflow for inference event and service data mapping function enables the Inference data to model matching is executed


### Service Data Model Lookup
Service Data model lookup enables matching query requests on a given set of AI models (their metadata). Enabling model lookup, one can filter available AI models against Zeiss Meditec and medical-specific search and lookup criteria.
More about application domain concepts on model lookup - [Refer here](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8469/Feature-Model-Lookup)

### Retrieval of Historical data from Azure Table Storage

Clients to retrieve the historical data which is saved to the Azure Table storage and Azure Cosmos DB. 

### End to End service orchestration work-flow Engine
Client application sends request against API Management (APIM) which sends the POST request to the workflow orchestration azure functions like Model mapping, Model look-up and Model Invocation

Model look-up interacts with Azure Container Registry for the model matching with correct label name using model metadata. 

Model Invocation function invokes the AI Algorithm hosted into Azure Kubernetes Service and application creates predictions and stores into Azure Table Storage. A notification is sent to Azure Service Bus. 
The client application is subscribed to the service bus and receives the notification and finally retrieves predictions from Azure Table Storage.
       
     
## Infrastructure components

### Azure Container Registry(ACR)

Azure Container Registry is a managed registry service based on the open-source Docker Registry 2.0. This helps to store and manage the container images and artifacts. 

AIXS platform allows Clients to push the OCI artifacts to public ACR and these images are scanned for any security vulnerabilities and pushed to private registry for the model management.

### Azure Key vault

Azure Key Vault is an Key management solution and cloud service that provides a secure store for secrets. It securely store keys, passwords, certificates, and other secrets. Access to a key vault requires proper authentication and authorization before a caller (user or application) can get access. 
Authentication establishes the identity of the caller, while authorization determines the operations that they are allowed to perform.
Authentication is done via Azure Active Directory. Authorization may be done via Azure role-based access control (Azure RBAC) or Key Vault access policy. 

AI Product application in AIXS can securely access the information they need by using URIs. These URIs allow the applications to retrieve specific versions of a secret. 
There is no need to write custom code to protect any of the secret information stored in Key Vault.

### Azure Table Storage

Azure Table storage stores large amounts of structured data. Azure Table storage is a service that stores non-relational structured data in the cloud, providing a key/attribute store with a schemaless design.

Here in AI Platform , All Inference results to be saved to the Azure storage accounts & AI Client application can retrieve the inference results from their storage accounts.
      
### API Management

[About API Management](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8504/API-Management)

Client application sends request against API Management (APIM) which sends the POST request to the workflow orchestration azure functions where algorithm executes and saves the inference results to storage account and retrieves inference results through GET API endpoint.

### Database

All Inference results will be saved to Azure Cosmos Database.

# Performance Tests

 The integration test of the AIXS shall include performance testing on the end points and benchmark performance values such as - 

- Average Service response time. 
- Average AI Algorithm response time.
- Average Platform response time.
- Avg. Number of parallel requests serviced.
- Service Rate (Total Response/Total Request). 

# Test cases Matrix

Attached document gives the detail test cases against each components with respect to Application, Infra & E2E.

[AIXS Test Cases Matrix_V0.1.xlsx](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform?path=/documentation/Testing/test_cases_matrix.md&version=GB444520_test_plan_for_integration_tests)

# Testing Procedures

## Test Execution

All Integration Tests are automated using Python BDD Framework and each test case will have a series of actions and expected results. As each action is performed, the results are evaluated. If the observed results are equal to the expected results, a checkmark is placed in the “pass” column. If the observed results are not equal to the expected results, a checkmark is placed in the “fail” column.

## Pass/Fail Criteria

To pass the system integration test, the following criteria must be met:

All features/components to function correctly as per the business requirements.

## Defect Management

Bugs detected during this phase must be accessible for a statistical evaluation.
Bugs are managed and monitored during this test phase in Azure DevOps. 

Change Control Board meeting(CCB)
The goal of CCB is to evaluate, prioritize and assign the resolution of defects. The team needs to validate severities of the defect, make changes as per need, finalize resolution of the defects, and assign resources. 

## Bug Management workflow:

|**Status**| **Description** |
|--|--|
|New  | The New bug shall be created in the DevOps , If there are any deviations found on the expected behavior and will be assigned to the concern team |
| Active |Concern team working on the bug/task and the status will be active  |
| Resolved |The concern team completed the work, or fixed, code reviewed, unit test is passed and is ready to verify  |
| Closed |The bug is moved to closed state when the tests executed successfully, acceptance criteria are met, and task completed.  |
| Removed  |The bug, which is obsolete, or not required, shall be remove.  |

Note : Program manager holds the responsibility of assigning the bugs to the concern team and create tasks accordingly.

# Risks and Contingencies

This section describes the system or project risks and the contingency plans that should take effect if the project experiences problems.

## Training

The existing SQA team has good knowledge on API automation using python. However, they need training on python programming and Azure infrastructure components to perform integration testing. A series of self-learning and classroom training is planned.

Note: SQA team will need 6 to 8 weeks to apply the learning from training into reality and get enough experience to take ownership on integration testing. 










