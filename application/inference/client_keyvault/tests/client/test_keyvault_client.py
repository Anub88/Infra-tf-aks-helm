from types import SimpleNamespace
from unittest import mock

import pytest
from azure.core.exceptions import HttpResponseError, ResourceNotFoundError
from azure.keyvault.certificates import CertificateClient
from azure.keyvault.secrets import SecretClient

from mlware_keyvault_client.client.keyvault_client import KeyVaultClient, KeyVaultException


def test_creation_of_key_vault_client_with_no_credentials_should_raise_exception():
    with pytest.raises(KeyVaultException):
        KeyVaultClient(credential=None)


# SECRET CLIENT SUBTESTS HERE


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_secret(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_secret_client", mock.MagicMock(spec=SecretClient)):
        kv_client._secret_client.get_secret.return_value = SimpleNamespace(value="3")

        # When
        secret = kv_client.get_secret(key="key")

        # Then
        assert secret == "3"


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_secret_http_error(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_secret_client", mock.MagicMock(spec=SecretClient)):
        kv_client._secret_client.get_secret.side_effect = HttpResponseError()

        # When Then
        with pytest.raises(KeyVaultException):
            kv_client.get_secret(key="somekey")


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_secret_nothing_found_error(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_secret_client", mock.MagicMock(spec=SecretClient)):
        kv_client._secret_client.get_secret.side_effect = ResourceNotFoundError()

        # When Then
        with pytest.raises(ResourceNotFoundError):
            kv_client.get_secret(key="somekey")


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_secret_no_key(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    # When Then
    with pytest.raises(Exception):
        kv_client.get_secret()


# CERTIFICATE CLIENT SUBTESTS HERE


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_certificate(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_cert_client", mock.MagicMock(spec=CertificateClient)):
        kv_client._cert_client.get_certificate.return_value = "3"

        # When
        cert = kv_client.get_certificate(name="somecert")

        # Then
        assert cert == "3"


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_certificate_http_error(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_cert_client", mock.MagicMock(spec=CertificateClient)):
        kv_client._cert_client.get_certificate.side_effect = HttpResponseError()

        # When Then
        with pytest.raises(KeyVaultException):
            kv_client.get_certificate(name="somecert")


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_certificate_nothing_found_error(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    with mock.patch.object(kv_client, "_cert_client", mock.MagicMock(spec=CertificateClient)):
        kv_client._cert_client.get_certificate.side_effect = ResourceNotFoundError()

        # When Then
        with pytest.raises(ResourceNotFoundError):
            kv_client.get_certificate(name="somecert")


@mock.patch("mlware_keyvault_client.client.keyvault_client.__new__")
def test_get_certificate_no_name(mocked_kv):
    # Given
    kv_client = KeyVaultClient()

    # When Then
    with pytest.raises(Exception):
        kv_client.get_certificate()
