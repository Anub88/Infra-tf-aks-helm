from azure.core.exceptions import HttpResponseError, ResourceNotFoundError
from azure.identity import DefaultAzureCredential
from azure.keyvault.certificates import CertificateClient, KeyVaultCertificate
from azure.keyvault.secrets import SecretClient
from mlware.configuration import workflow_configuration
from mlware.platform_exceptions import (AIXSPlatformApplication,
                                        AIXSPlatformError)
from mlware_keyvault_client.error_codes import AIXSErrorCode


class KeyVaultException(AIXSPlatformError):
    def __init__(self, error_cause, message):
        super().__init__(
            error_cause=error_cause,
            application_code=AIXSPlatformApplication.CLIENT_KEYVAULT,
            error_code=AIXSErrorCode.KEYVAULTEXCEPTIONERRORCODE.value,
            message=f"Could not query keyvault: {message}",
        )


class KeyVaultClient:
    """Wrapper for the Keyvault SDK to fetch secrets and certificates.

    Parameters:
        vault_url: URL pointing @ desired Azure KeyVault

    Raises:
        KeyVaultException: SDK client creation failed due to
        missing/bad vault_url or network connection
        ResourceNotFoundError: Unknown key requested.
    """

    _secret_client: SecretClient

    _cert_client: CertificateClient

    def __init__(
        self,
        vault_url: str = workflow_configuration.VAULT_URL,
        credential=DefaultAzureCredential(),
    ) -> None:
        try:
            if vault_url == "":
                raise KeyVaultException(
                    error_cause=None,
                    message="No key vault url has been provided, cannot establish connection",
                )
            self._secret_client = SecretClient(
                vault_url=vault_url,
                credential=credential,
            )
            self._cert_client = CertificateClient(
                vault_url=vault_url,
                credential=credential,
            )
        except Exception as error:
            raise KeyVaultException(
                error_cause=error, message="Failed to inititaliaze keyvault client"
            ) from error

    def get_secret(self, key: str) -> str:
        """Fetch a secret from Keyvault.

        Args:
            key (str): Key of the desired Key<->Secret pair

        Raises:
            KeyVaultException: No key provide or no connection.

        Returns:
            str: The secret value stored at the given key.
        """
        if key == "":
            raise KeyVaultException(error_cause=None, message="no key provided")
        try:
            secret = self._secret_client.get_secret(key)
        except ResourceNotFoundError:
            raise ResourceNotFoundError(f"Unknown key {key}")
        except HttpResponseError as err:
            raise KeyVaultException(error_cause=err, message=str(err))
        else:
            return secret.value

    def get_certificate(self, name: str) -> KeyVaultCertificate:
        """Fetch a certificate from Keyvault.

        Args:
            Name (str): Name of the desired certificate

        Raises:
            KeyVaultException: No key provide or no connection.

        Returns:
            KeyVaultCertificate: The certificate.
        """
        if name == "":
            raise KeyVaultException(error_cause=None, message="no certificate name provided")
        try:
            certificate = self._cert_client.get_certificate(certificate_name=name)
        except ResourceNotFoundError:
            raise ResourceNotFoundError(f"Unknown certificate {name}")
        except HttpResponseError as err:
            raise KeyVaultException(error_cause=err, message=str(err))
        else:
            return certificate
