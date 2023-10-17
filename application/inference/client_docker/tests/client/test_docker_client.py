import pytest
from mlware_client_acr_docker.client.docker_client import (
    ACRDockerClient,
    AzureACRDockerClientException,
)


def test_try_to_initialize_acr_docker_client_without_registry_url_should_raise_client_exception():
    with pytest.raises(AzureACRDockerClientException) as error:
        ACRDockerClient(
            oci_repository_username="username",
            oci_repository_password="password",
            registry_url=None,
        )
        assert error.get_application_error_code() == "1-100"


def test_try_to_initialize_acr_docker_client_deamon_not_run_should_raise_client_exception():
    # Given & When & Then
    with pytest.raises(AzureACRDockerClientException) as error:
        ACRDockerClient(
            oci_repository_username="username",
            oci_repository_password="password",
            registry_url="registry_url",
        )
        assert error.get_application_error_code() == "1-100"
