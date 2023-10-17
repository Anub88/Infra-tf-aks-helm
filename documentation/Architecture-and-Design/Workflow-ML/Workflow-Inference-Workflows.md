## Workflow Resonsibilities
The main workflow engine responsibilities with respect to inference are:
- (Data) pre-processing and normalization
- Data-to-model mapping
- Inference status monitoring

## Inference Workflow Context
![inference_workflow_engine.svg](../.attachments/inference_workflow_engine.svg)

## Workflow Implementation

### Using Durable Functions
Durable functions, especially [Durable Function Chaining](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=python#chaining),
allow for carrying state (Inference IDs, Error Tracking) in multiple, chained, Azure functions. See the [durable functions reference](../Onboarding/Azure-Durable-Functions.md).

```
+ Eliminates the need of API / endpoint handling since the 
  orchestrator function is responsible (handled by Azure)
+ Linear paths/function chains, e.g. 2.2a to 2.2c can be added 
  easily, only the orchestrator is edited
- Functions in the chain are only callable by the orchestrator
  Testing them independently is not possible
  Reusing them outside the chains is not possible
```

### Using Regular Functions


```
+ More flexible
  Test/Reuse individual functions easily
- More implementation overhead
  Orchestrator must be written manually
  Function APIs must be defined and written (FastAPI)
```