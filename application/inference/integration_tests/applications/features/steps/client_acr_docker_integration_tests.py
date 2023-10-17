from uuid import uuid4
from behave import *
from pathlib import Path
from mlware_client_acr_docker.client.docker_client import ACRDockerClient, AzureACRDockerClientException
from configuration import integration_test_configuration
from environment import circuit_breaker

@given('ACR client is initialized with token username "{token_username}" and token password name "{token_password}"')
def client_acr_docker_acr_client_initialized(context, token_username, token_password):
    context.acr_docker_client = ACRDockerClient(
        oci_repository_username=getattr(integration_test_configuration, token_username),
        oci_repository_password=getattr(integration_test_configuration, token_password),
    )


@given('OCI registry name "{registry_name}"')
def client_acr_docker_registry_given(context, registry_name):
    context.registry_name = registry_name


@given('OCI image repository "{docker_repository}"')
def client_acr_docker_repository_given(context, docker_repository):
    context.docker_repository = docker_repository


@given('OCI image tag "{docker_tag}"')
def client_acr_docker_tag_given(context, docker_tag):
    context.docker_tag = docker_tag


@given("OCI image tag as uuid")
def client_acr_docker_tag_uuid_given(context):
    context.docker_tag = str(uuid4())


@when("Local OCI image is built")
def client_acr_docker_build_image(context):
    # Building OCI image from local dockerfile (see test_artifacts/Dockerfile)
    context.acr_docker_client.build_image(
        working_directory=".",
        dockerfile_location=Path.joinpath(integration_test_configuration.MODULE_BASE_PATH, "test_artifacts", "Dockerfile"),
        docker_registry_repository_and_tag=f"{context.registry_name}/{context.docker_repository}:{context.docker_tag}",
    )


@when("OCI image is pushed to remote OCI image repository successfully")
@circuit_breaker
def client_acr_docker_push_image(context):
    context.acr_docker_client.push_image(
        docker_registry_repository_and_tag=f"{context.registry_name}/{context.docker_repository}:{context.docker_tag}"
    )


@when("OCI image is pulled from remote OCI image repository")
@circuit_breaker
def client_acr_docker_pull_image(context):
    context.image_id = context.acr_docker_client.pull_image(
        docker_registry_repository_and_tag=f"{context.registry_name}/{context.docker_repository}:{context.docker_tag}"
    )


@then("OCI image with image id is available")
def client_acr_docker_assert_on_oci_image_id(context):
    assert context.image_id is not None


@then("OCI image push to remote OCI image repository fails with access denied")
@circuit_breaker
def client_acr_docker_push_image_failing(context):
    try:
        context.acr_docker_client.push_image(
            docker_registry_repository_and_tag=f"{context.registry_name}/{context.docker_repository}:{context.docker_tag}"
        )
    except AzureACRDockerClientException as error:
        assert "denied" in error.message
