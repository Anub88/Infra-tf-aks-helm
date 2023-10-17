# Overview
The AIXS platform needs to handle errors in a consistent (standard) way, so that error situations can be processed and analyzed/treated in a common way. This error standard comprises elements like:
- error cause: the initial error causing the AIXS platform error
- error description and error message: a specific and precise description of what error situation happened
- application code: code represents the application where the error situation happened
- error code: code that respresents the error situation for easy lookup

# Platform Error Codes
Application error codes for AIXS platform applications listed with error code and error message. Each application gets assigned an application code and specific (custom) error contexts are specified by a specific error code. The combination of application code and error code enables to answer the questions "Where in the platform occurred the error situation?" (application code) and "What happened?" (error code).

Error codes are constructed from an application code and error code.

Note: Generic error codesserve as generic fallback when no more specific error description could be provided. Generic error codes should be used with care, since they don't provide detailed information about the error situation.

Specification with AIXSPlatformError base class:
```python
class CustomAIXSPlatformError(AIXSPlatformError):
    def __init__(self, error_cause, application_code, error_code, message):
        super().__init__(error_cause, application_code, error_code, message)
```

In order to serialize the error as string, just use: ``str(<custom-error-object>)``

This will produce an error string as:
```
Error cause: {str(type(custom_error.error_cause).__name__)},
error cause message: {str(custom_error.error_cause)},
application affected (application code): {custom_error.application_code},
error code: {custom_error.error_code},
error message: {custom_error.message}
```

## Inference
The inference part of the platform error codes and messages listed per application.

### Generic Errors
Generic error codes are only fallback codes, if no specific error code could be provided. The error codes of generic errors are 1-2 digits. Generic errors should be used very carefully, since they don't enable to identify and resolve the error cause efficiently.

| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 0 | 1  | AIXSPlatformError | Generic AIXS application error |

### Client Docker
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 1 | 100  | AzureACRDockerClientException  |  Failing docker communication and processing  |

### Client Inference Data
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 2 | 100  | StorageQueryException  | Querying azure storage failed  |
| 2 | 101  | StorageClientInitException  | Creating storage client failed  |
| 2 | 102  | InferenceResultsDataStorageException  | Storage of inference results data failed  |

### Client Keyvault
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 3 | 100  | KeyVaultInitException  | Creating keyvault client failed  |
| 3 | 101  | KeyVaultException  | Could not query keyvault  |

### Platform Foundation
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 4 | to do | to do | to do |


### Service Historical Data Retrieval
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 5 |  to do | to do | to do |


### Service Model Lookup
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 6 | 0 |  GENERICMODELLOOKUPERRORCODE  | Generic fallback error |
| 6 | 1 | JSONVALIDATIONERRORCODE  | Json validation exception |
| 6 | 100 | AzureACRException  | Azure SDK exception |
| 6 | 101 | ACRClientException  | ACR Client exception  |
| 6 | 102 | RepoNotFoundException  | Azure ACR repository not found  |
| 6 | 103 | ACRClientBuilderException  | Creating ACR client failed  |
| 6 | 104 | ACRServiceError | ACR service processing failed  |
| 6 | 105 | LOOKUPCONTROLLERERRORCODE | Lookup service controller exception |
| 6 | 106 | LOOKUPDOMAINMODELERRORCODE | Lookup service domain exception |


### Service Inference Orchestration
| Application code | Error code | Error name | Error message  |
|---|---|---|---|
| 7 |  to do | to do | to do |
