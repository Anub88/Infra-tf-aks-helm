# Durable Orchestrations

Durable orchestrations are made up from three distinct function types:

- orchestrator (orchestrationTrigger)

    Manages execution flow, dont use other input/output bindings, dont use async, dont do undeterministic things. See the full list of [limitations](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-code-constraints).
- starter/client (durableClient)

    Invoke/terminate the orchestrator. Query the orchestrator, send events while an orchestrator is running.
- activity (activityTrigger)

    Basic units of work. Are not restricted. At least once guarantee.
- entity (entityTrigger)

    As activity functions but carry pieces of state.

## Workflow

The model_lookup_service is implemented as a regular azure function to
- enable its use outside of this function chain
- and allow the mapping service to use it directly.
