# Overview
The MLware solution serves as platform for training and inference processes in AI solutions' medical contexts. Because of the medical context, a specific degree of observability, traceability and auditability of those processes needs to be ensured.

# Technology
From technological perspective, an Azure-integrated approach is implemented, using Azure Monitor's capabilities for logging, metrics, and alerting.

The following classes of monitoring is intended to be covered by MLware platform:

## Cost Monitoring
Monitoring the infrastrucural (Azure) costs with application/usage/consumer details, in order to cross-reference occurring costs to origin.

## Application Monitoring
The application monitoring covers Azure SaaS, PaaS logs and alerts, but also AI model application specific logs and alerts. 

### Performance Monitoring
In terms of performance monitoring, it is relevant to cover specifically metrics about:
- response and execution times
- efficiency of execution processes

### Functional Monitoring
The functional monitoring relates to AI model application logs, serving the purpose to analyze the processes and events occurring specifically during AI inference, using audit and trace logs.

## Infrastructure Monitoring
The infrastrucural monitoring covers the lower level infrastructural metrics (like CPU, memory usage), but also infrastructure availability in general.

### Health Monitoring
Health monitoring can be considered on Azure infrastructure level, but also on (AI model) application level.