from azure.core.exceptions import ResourceNotFoundError
from azure.keyvault.certificates import KeyVaultCertificate
from behave import *
from environment import circuit_breaker
from mlware.configuration import workflow_configuration
from mlware_keyvault_client.client.keyvault_client import KeyVaultClient


@given("Keyvault client is initialized for keyvault check")
def keyvault_client_initialized(context):
    context.keyvault_client = KeyVaultClient(
        vault_url=workflow_configuration.VAULT_URL_INTEGRATION_TEST
    )
    assert context.keyvault_client is not None


@when('Keyvault client tries to retrieve key "{key}" from key vault')
@circuit_breaker
def keyvault_client_secret_retrieval(context, key):
    try:
        context.secret = None
        context.secret = context.keyvault_client.get_secret(key=key)
    except Exception as error:
        context.exception = error


@then("Secret is available as string")
def secret_available(context):
    assert (
        context.secret is not None
    ), "Secret is not available and not correctly retrieved from keyvault"
    assert isinstance(context.secret, str)


@then("Secret is not available as string and exception is available")
def secret_not_available_available(context):
    assert context.exception is not None
    assert isinstance(context.exception, ResourceNotFoundError)


@when('Keyvault client tries to retrieve name "{certificate_name}" from key vault')
@circuit_breaker
def keyvault_client_certificate_retrieval(context, certificate_name):
    try:
        context.certificate = None
        context.certificate = context.keyvault_client.get_certificate(
            name=certificate_name
        )
    except Exception as error:
        context.exception = error


@then("Certificate is available as object")
def certificate_available(context):
    assert (
        context.certificate is not None
    ), "Secret is not available and not correctly retrieved from keyvault"
    assert isinstance(context.certificate, KeyVaultCertificate)


@then("Certificate is not available as object and exception is available")
def certificate_not_available_available(context):
    assert context.exception is not None
    assert isinstance(context.exception, ResourceNotFoundError)
