import pytest

from mlware_keyvault_client.client.keyvault_client import KeyVaultClient

from mlware_data_access_client.client.tablestorage_results_storage_client import (
    TableStorageClientBuilder,
    TableStorageClient,
)
from mlware_data_access_client.client.cosmos_results_storage_client import (
    InferenceResultsStorageClient,
)

from mlware.configuration import workflow_configuration

@pytest.mark.skip("This is an integration test, which needs to be moved out from here")
def test_build_table_storage_client():
    # Given
    kv_client = KeyVaultClient(workflow_configuration.VAULT_URL)

    # When
    client = TableStorageClientBuilder.build(kv_client=kv_client)

    # Then
    assert isinstance(client, InferenceResultsStorageClient)
    assert isinstance(client, TableStorageClient)
