from mlware.platform_exceptions import AIXSPlatformError, AIXSPlatformApplication
from mlware_data_access_client.error_codes import AIXSErrorCode


class StorageQueryException(AIXSPlatformError):
    def __init__(self, error_cause, message):
        message = f"Querying azure storage failed: {message}"
        super().__init__(
            error_cause=error_cause,
            application_code=AIXSPlatformApplication.CLIENT_INFERENCE_DATA,
            error_code=AIXSErrorCode.STORAGEQUERYEXCEPTIONERRORCODE.value,
            message=message,
        )


class StorageClientInitException(AIXSPlatformError):
    def __init__(self, error_cause, message):
        message = f"Creating storage client failed: {message}"
        super().__init__(
            error_cause=error_cause,
            application_code=AIXSPlatformApplication.CLIENT_INFERENCE_DATA,
            error_code=AIXSErrorCode.STORAGECLIENTINITEXCEPTIONERRORCODE.value,
            message=message,
        )


class InferenceResultsDataStorageException(AIXSPlatformError):
    def __init__(self, error_cause, message):
        message = f"Storage of inference results data failed: {message}"
        super().__init__(
            error_cause=error_cause,
            application_code=AIXSPlatformApplication.CLIENT_INFERENCE_DATA,
            error_code=AIXSErrorCode.INFERENCERESULTSDATASTORAGEEXCEPTIONERRORCODE.value,
            message=message,
        )
