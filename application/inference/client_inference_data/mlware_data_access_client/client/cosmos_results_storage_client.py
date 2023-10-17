"""
Wrapper for Azure Cosmos DB


TODO:
    - Decide on which cosmos container/API to use
    -
"""

import logging
from typing import List

from azure.cosmos import CosmosClient
from azure.cosmos.exceptions import CosmosHttpResponseError
from azure.identity import DefaultAzureCredential
from mlware.configuration import workflow_configuration
from mlware_data_access_client.client.abstract_results_storage_client import (
    InferenceResultsStorageClient,
)
from mlware_data_access_client.client.dto import (
    InferenceQueryDto,
    InferenceQueryResultDto,
    InferenceResultsDto,
)
from mlware_data_access_client.client.errors import (
    InferenceResultsDataStorageException,
    StorageQueryException,
)


class AzureCosmosDBClient(InferenceResultsStorageClient):
    def __init__(
        self,
        url_connection: str,
        database_name: str,
        credential: DefaultAzureCredential,
        consistency_level: str,
        tenant: str,
    ):
        self.database_name: str = database_name
        self.container_name: str = tenant
        self.cosmos_client: CosmosClient = CosmosClient(
            url_connection, credential, consistency_level=consistency_level
        )
        self.database_client = self.cosmos_client.get_database_client(
            self.database_name
        )
        self.container_client = self.database_client.get_container_client(
            self.container_name
        )

        logging.info(
            "Created cosmos db client for tenant {tenant} with url {url_connection}, consistency level {consistency_level}".format(
                tenant=tenant,
                url_connection=url_connection,
                consistency_level=consistency_level,
            )
        )

    def store_data_in_target(self, inference_results: InferenceResultsDto):
        try:
            logging.info(
                f"Storing {len(inference_results.json_documents)} element(s) in Cosmos DB"
            )
            for json_document in inference_results.json_documents:
                self.container_client.create_item(
                    json_document.get_inference_results_with_id()
                )
                logging.info(f"Stored document with id {json_document.id} in Cosmos DB")

        except CosmosHttpResponseError as err:
            message = "Failed to persist document in Cosmos DB"
            logging.error(message)
            raise InferenceResultsDataStorageException(
                error_cause=err,
                message="{message}: {inner_error}".format(
                    message=message, inner_error=repr(err)
                ),
            )
        except Exception as err:
            message = "Failed to persist document in Cosmos DB"
            logging.error(message)
            raise InferenceResultsDataStorageException(
                error_cause=err,
                message="{message}: {inner_error}".format(
                    message=message, inner_error=repr(err)
                ),
            )

    def query_inference_results(
        self, query: InferenceQueryDto
    ) -> List[InferenceQueryResultDto]:

        # NOTE: Any value for the container name in the from clause can be used
        try:
            query = f"SELECT * FROM container c WHERE c.examid = '{query.ExamId}'"
            results = self.container_client.query_items(
                query=query,
                enable_cross_partition_query=True,
            )

        except Exception as err:
            raise StorageQueryException(
                error_cause=err,
                message=f"Unable to query cosmos container {self.container_name} in database {self.database_name}: {err}",
            ) from err
        else:
            return list(results)


class AzureCosmosDBClientBuilder:
    def __init__(self):
        self.url_connection: str = None
        self.credential: DefaultAzureCredential = None
        self.database_name: str = None
        self.container_name: str = None
        self.consistency_level: str = None

    def with_url_conncetion(
        self, url_connection: str = workflow_configuration.COSMOS_DB_URL
    ):
        self.url_connection = url_connection
        return self

    def with_credential(
        self, credential: DefaultAzureCredential = DefaultAzureCredential()
    ):
        self.credential = credential
        return self

    def with_database_name(self, database_name: str):
        self.database_name = database_name
        return self

    def with_container_name(self, container_name: str):
        self.container_name = container_name
        return self

    def with_consistency_level(self, consistency_level: str = "Strong"):
        self.consistency_level = consistency_level
        return self

    def build(self) -> InferenceResultsStorageClient:
        return AzureCosmosDBClient(
            url_connection=self.url_connection,
            database_name=self.database_name,
            credential=self.credential,
            consistency_level=self.consistency_level,
            tenant=self.container_name,
        )
