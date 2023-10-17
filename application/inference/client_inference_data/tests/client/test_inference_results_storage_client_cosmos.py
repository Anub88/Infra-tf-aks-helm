import pytest
from mlware.configuration import workflow_configuration
from mlware_data_access_client.client.cosmos_results_storage_client import (
    AzureCosmosDBClient, AzureCosmosDBClientBuilder,
    InferenceResultsStorageClient)
from mlware_data_access_client.client.dto import InferenceQueryDto


@pytest.mark.skip("This is an integration test, which needs to be moved out from here")
def test_build_cosmos_storage_client():
    # Given
    cosmos_url = workflow_configuration.COSMOS_DB_URL

    # When
    client = (
        AzureCosmosDBClientBuilder()
        .with_credential()
        .with_url_conncetion()
        .with_consistency_level()
        .build()
    )

    # Then
    assert isinstance(client, InferenceResultsStorageClient)
    assert isinstance(client, AzureCosmosDBClient)


@pytest.mark.skip("This is an integration test, which needs to be moved out from here")
def test_cosmos_storage_client():
    # Given
    client = (
        AzureCosmosDBClientBuilder()
        .with_credential()
        .with_url_conncetion()
        .with_consistency_level()
        .with_database_name("mlw-poc-data-access")
        .with_container_name("ODX")
        .build()
    )
    query = InferenceQueryDto(
        TenantId="6543", ExamId="0c210ad8-33ec-4958-bab7-abbb99648e79"
    )

    # When
    results = client.query_inference_results(query)

    # Then
    assert isinstance(client, InferenceResultsStorageClient)
    assert isinstance(client, AzureCosmosDBClient)
