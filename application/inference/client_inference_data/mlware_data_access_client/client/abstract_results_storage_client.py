from abc import ABCMeta, abstractmethod

from abc import ABCMeta, abstractmethod

from mlware_data_access_client.client.dto import (
    InferenceQueryDto,
    InferenceQueryResultDto,
    InferenceResultsDto,
)


class InferenceResultsStorageClient(metaclass=ABCMeta):
    @abstractmethod
    def store_data_in_target(self, inference_results: InferenceResultsDto):
        pass

    @abstractmethod
    def query_inference_results(
        self, query: InferenceQueryDto
    ) -> InferenceQueryResultDto:
        pass
