from typing import List

from azure.core.exceptions import ResourceNotFoundError
from azure.data.tables import TableServiceClient
from mlware_data_access_client.client.abstract_results_storage_client import (
    InferenceResultsStorageClient,
)
from mlware_data_access_client.client.dto import (
    InferenceQueryDto,
    InferenceQueryResultDto,
    InferenceResultsDto,
)
from mlware_data_access_client.client.errors import (
    StorageClientInitException,
    StorageQueryException,
)
from mlware_keyvault_client.client.keyvault_client import KeyVaultClient


class TableStorageClient(InferenceResultsStorageClient):
    _sdk_service_client: TableServiceClient

    def __init__(self, client: TableServiceClient):
        if client is None:
            raise StorageClientInitException(
                error_cause=None, message="No tablestorage sdk provided"
            )

        self._sdk_service_client = client

    def query_inference_results(
        self, query: InferenceQueryDto, table: str
    ) -> List[InferenceQueryResultDto]:

        with self._sdk_service_client.get_table_client(table) as table_client:
            if table_client is None:
                raise StorageQueryException(
                    error_cause=None,
                    message=f"Unable to create client for table {table}",
                )

            filter = "ExamId eq @examid and TenantId eq @tenantid"
            params = {"examid": query.ExamId, "tenantid": query.TenantId}
            try:
                results = table_client.query_entities(
                    query_filter=filter,
                    parameters=params,
                )
            except Exception as err:
                raise StorageQueryException(
                    error_cause=err,
                    message=f"Unable to query entities on table {table}: {err}",
                ) from err
            else:
                return list(results)

    def store_data_in_target(self, inference_results: InferenceResultsDto):
        raise NotImplementedError()


class TableStorageClientBuilder:
    @classmethod
    def build(cls, kv_client: KeyVaultClient, table_storage_account: str, table_storage_key: str):
        try:
            ts_account = table_storage_account
            ts_key = kv_client.get_secret(table_storage_key)
        except ResourceNotFoundError as error:
            raise StorageClientInitException(
                error_cause=error, message="No connection details found in keyvault"
            ) from error

        return cls._from_key(ts_account, ts_key)

    @staticmethod
    def _from_credential(endpoint: str, credential) -> InferenceResultsStorageClient:
        sdk_client = TableServiceClient(
            endpoint=endpoint,
            credential=credential,
        )
        return TableStorageClient(sdk_client)

    @staticmethod
    def _from_key(account: str, key: str) -> InferenceResultsStorageClient:
        conn = f"DefaultEndpointsProtocol=https;AccountName={account};AccountKey={key};EndpointSuffix=core.windows.net"
        sdk_client = TableServiceClient.from_connection_string(conn_str=conn)
        return TableStorageClient(sdk_client)
