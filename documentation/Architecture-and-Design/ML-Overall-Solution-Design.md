
# Overview
The solution design is addressing the business capability and requirement of a platform for Artificial Intelligence (AI) providing execution/deployment  environment and lifecycle management of AI solutions (AI training and AI inference). The AI solutions are implemented by means of Machine Learning (ML) concepts and rolled-out/deployed on cloud (Azure) infrastructure (naming of the AI platform: MLware solution).

## Architecture
The MLware solution (also AI backend) is covering the following main capabilities of:
- AI inference: deployment of AI solutions, executing inference and producing predictions
- AI training: AI solution creation by iterative AI artifact/model improvement
- AI (shared) Workspace Hub: enabling concerns of monitoring, logging, data and model management (cross-cutting concerns for AI training and inference)

![solution_design_hub_and_spoke.svg](./.attachments/solution_design_hub_and_spoke.svg)


The main building blocks are presented in the subsequent sections.

## Technology
The MLware / AI backend is going to be implemented in an Azure cloud-native fashion. See [architectural decision records](./Architecture-Decisions/Architecture-Decision-Records.md) for details.

## Inference
AI inference is one major concern of the MLware solution. The main building blocks of the MLware solution are:
- Event-based inference invocation (incl. dynamic AI model-to-data mapping and service discovery)
- Scalable, elastic AI-solution-specific computation of inference
- Orchestration of AI inference processes (incl. service registry)

### Service Registry
A service registry is required for runtime service discovery, serving the purpose of AI model to inference data mapping.

## ML Workspace Hub
The ML Workspace Hub serves the purpose of:
- entry-point (e. g. site-to-site connectivity between on-premise network and Azure cloud netword)
- secrets management
- model management (incl. model registry)
- data management (training)
- logging and monitoring of AI solutions

### Model Registry
The model registry is a compile-time AI model registry for model discovery. The model discovery enables lookups of available AI models with specific AI capabilities enabling to match AI models against inference data.

## Training
AI training is a major concern creating AI solutions and is included in the MLware solution. The main building blocks of the MLware solution are:
- (Re-)Training pipelines for AI artifact/model creation
- AI Model tracking (using model metrics)
- Model management and model registration
- Data management (including data drift concerns) during training phase

## Deployment
The presented solution design needs to respect regional and geographic (national) regulatory (national medical regulation) and GDPR concerns. Therefore, the solution design needs to be potentially setup in a geographically distributed (regional) way.