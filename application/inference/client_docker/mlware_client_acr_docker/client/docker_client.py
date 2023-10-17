import logging

import docker

from mlware.platform_exceptions import AIXSPlatformError, AIXSPlatformApplication
from mlware.configuration import workflow_configuration
from mlware_keyvault_client.client.keyvault_client import KeyVaultClient
from mlware_client_acr_docker.error_codes import AIXSErrorCode


class AzureACRDockerClientException(AIXSPlatformError):
    def __init__(self, error_cause, message):
        message = f"Failed to execute docker command: {message}"
        super().__init__(
            error_cause=error_cause,
            application_code=AIXSPlatformApplication.CLIENT_DOCKER,
            error_code=AIXSErrorCode.AZUREACRDOCKERCLIENTERRORCODE.value,
            message=message,
        )


class ACRDockerClient:
    def __init__(
        self,
        oci_repository_username: str,
        oci_repository_password: str,
        registry_url: str = workflow_configuration.ACR_PUBLIC_SERVER,
        key_vault_client: KeyVaultClient = KeyVaultClient(workflow_configuration.VAULT_URL),
    ):
        """
        Initialize the acr docker client and logs the client in to the Azure Container Registry oci image registry.
        Using Azure Keyvault secrets to retrieve credentials for connectivity to Azure Container Registry
        (token-based authentication and authorization of ACR repository).

        Args:
            oci_repository_username (str): ACR token-based authentication - token name (as username)
            oci_repository_password (str): ACR token-based authentication - token (as password)
            registry_url (str): is the full url pointing to the ACR docker registry
            key_vault_client (KeyVaultClient): is the keyvault client required to retrieve username and password details for ACR docker registry
        """

        if registry_url is not None:
            self.registry_url = registry_url
        else:
            raise AzureACRDockerClientException(
                error_cause=None, message="No ACR url provided for registry connectivity"
            )

        try:
            self.docker_client = docker.from_env()
            logging.info("Created ACR docker client from docker daemon environment details.")
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error,
                message=f"ACR client initialization failure, did you miss to run docker daemon? Docker daemon is a prerequisite for acr docker client, inner error '{error}'",
            ) from error

        try:
            self.oci_repository_username: str = key_vault_client.get_secret(oci_repository_username)
            self.oci_repository_password: str = key_vault_client.get_secret(oci_repository_password)
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error,
                message=f"Retrieval of docker client credentials failed, error '{error}'",
            ) from error

        try:
            self.docker_client.login(
                username=self.oci_repository_username,
                password=self.oci_repository_password,
                registry=registry_url,
            )
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error,
                message=f"ACR client initialization failure, log in to Azure Container Registry with docker client failed, error '{error}'",
            ) from error

        logging.info(
            "Logged docker client into Azure Container Registry '%s' with token credentials successfully",
            self.registry_url,
        )

    def build_image(
        self, working_directory: str, dockerfile_location: str, docker_registry_repository_and_tag: str
    ) -> str:
        """
        Encapsulates the OCI image build process

        Args:
            working_directory: is the local path for the docker image (as working directory)
            dockerfile_location: is the subpath pointing to a local dockerfile
            docker_registry_repository_and_tag: naming the image with a docker repository name and tag in the way <registry-name>/<repository>:<tag>
        Returns:
            imaged_id (str): built OCI image id
        """

        try:
            image_tuple = self.docker_client.images.build(
                path=working_directory, dockerfile=dockerfile_location, tag=docker_registry_repository_and_tag
            )
            logging.info(
                f"Built OCI image with id '{image_tuple[0].id}' and full name '{docker_registry_repository_and_tag}' from local path '{dockerfile_location}'"
            )
            return image_tuple[0].id
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error, message=f"Image build error, inner error '{error}'"
            ) from error

    def push_image(self, docker_registry_repository_and_tag: str) -> str:
        """
        Encapsulates the OCI image push process to the OCI repository

        Args:
            docker_registry_repository_and_tag: naming the image with a docker repository name and tag in the way <registry-name>/<repository>:<tag>
        
        Returns:
            server_output (str): response from OCI repository server
        
        """

        try:
            self.docker_client.images.get(f"{docker_registry_repository_and_tag}")
            server_output = self.docker_client.images.push(f"{docker_registry_repository_and_tag}")

            if "requested access to the resource is denied" in server_output:
                raise AzureACRDockerClientException(
                error_cause=None,
                message=f"Image push failed for OCI image '{docker_registry_repository_and_tag}' because of denied access with server output: {str(server_output)}",
                )
            else:
                logging.info(f"Pushed OCI image '{docker_registry_repository_and_tag}' to docker registry with server response: {str(server_output)}")

            return server_output
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error,
                message=f"Image push error of oci image name '{docker_registry_repository_and_tag}', inner error '{error}'",
            ) from error

    def pull_image(self, docker_registry_repository_and_tag: str) -> str:
        """
        Encapsulates the OCI image pull process from the OCI repository

        Args:
            docker_registry_repository_and_tag: naming the image with a docker repository name and tag in the way <registry-name>/<repository>:<tag>
        Returns:
            imaged_id (str): pulled OCI image id
        """

        try:
            image = self.docker_client.images.pull(f"{docker_registry_repository_and_tag}")

            logging.info(
                f"Pulled OCI image with id '{image.id}' with name '{docker_registry_repository_and_tag}' from docker registry"
            )

            return image.id
        except Exception as error:
            raise AzureACRDockerClientException(
                error_cause=error,
                message="Image pull error of oci image '{docker_registry_repository_and_tag}', inner error '{error}'",
            ) from error
