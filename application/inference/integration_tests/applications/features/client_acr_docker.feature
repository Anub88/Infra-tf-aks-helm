# Only execute those tests on dev
@only_dev
Feature: Client for Azure Container Registry (ACR)

@infrastructure.acr
Scenario: ACR docker client builds, pushes and pulls OCI image from and to AIXS platform ACR with authorization for repository successfully
    Given ACR client is initialized with token username "ACR_TOKEN_AUTHENTICATION_TOKEN_USERNAME_AUTH_FOR_TEST_REPRO" and token password name "ACR_TOKEN_AUTHENTICATION_TOKEN_PASSWORD_AUTH_FOR_TEST_REPRO"
    Given OCI registry name "acrpubmlwscicdweus.azurecr.io"
    Given OCI image repository "integration-tests"
    Given OCI image tag as uuid
    When Local OCI image is built
    When OCI image is pushed to remote OCI image repository successfully
    When OCI image is pulled from remote OCI image repository
    Then OCI image with image id is available

@infrastructure.acr
Scenario: ACR docker client builds OCI image and fails to push OCI image to AIXS platform ACR without authorization for repository
    Given ACR client is initialized with token username "ACR_TOKEN_AUTHENTICATION_TOKEN_USERNAME_AUTH_FOR_TEST_REPRO" and token password name "ACR_TOKEN_AUTHENTICATION_TOKEN_PASSWORD_AUTH_FOR_TEST_REPRO"
    Given OCI registry name "acrpubmlwscicdweus.azurecr.io"
    Given OCI image repository "oct_image_analyzer"
    Given OCI image tag "latest"
    When Local OCI image is built
    Then OCI image push to remote OCI image repository fails with access denied
