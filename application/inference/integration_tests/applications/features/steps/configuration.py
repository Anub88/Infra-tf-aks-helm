import os
from pathlib import Path
import logging
from pydantic import BaseSettings, Field
from mlware.configuration import workflow_configuration as global_configuration

class IntegrationTestBaseConfiguration(BaseSettings):

    AAD_TENANT: str = Field("82913d90-8716-4025-a8e8-4f8dfa42b719")
    FUNC_KEY_FUNC_API_MLAPI: str = Field("app-reg-func-key-func-api")
    FUNC_KEY_FUNC_LKUP_MLWF: str = Field("app-reg-func-key-func-lkup")
    FUNC_KEY_FUNC_ORCH_REST_MLWF: str = Field("app-reg-func-key-func-orch")
    FUNC_KEY_FUNC_ORCH_CLOUDEVENT_MLWF: str = Field("app-reg-func-key-func-orch")

    ACR_TOKEN_AUTHENTICATION_TOKEN_USERNAME_AUTH_FOR_TEST_REPRO: str = Field(
        "acrpubmlwscicdweus-integration-test-token-username"
    )

    ACR_TOKEN_AUTHENTICATION_TOKEN_PASSWORD_AUTH_FOR_TEST_REPRO: str = Field(
        "acrpubmlwscicdweus-integration-test-token-password"
    )

    SERVICE_ORCHESTRATION_URL_REST: str = Field(
        f"{global_configuration.ORCHESTRATOR_SERVICE_URL}/restevent"
    )

    SERVICE_ORCHESTRATION_URL_CLOUDEVENT: str = Field(
        f"{global_configuration.ORCHESTRATOR_SERVICE_URL}/cloudevent"
    )
    KV_TABLESTORAGE_KEY_ODX: str = Field("tablestorage-key-odx")

    MODULE_BASE_PATH = Field(Path(__file__).absolute().parents[2])


class IntegrationTestLocalConfiguration(IntegrationTestBaseConfiguration):
    pass
    # TODO add local settings

class IntegrationTestDevConfiguration(IntegrationTestBaseConfiguration):
    BSCAN_API_URL: str = Field("https://dev-aixs.zeiss.com/bscanofinterest")
    INTEGRATION_TEST_APP_REG_CLIENT_ID = Field("integration-tests-client-id-mlws-weus-dev")
    INTEGRATION_TEST_APP_REG_CLIENT_SECRET = Field("integration-tests-client-secret-mlws-weus-dev")
    SUBSCRIPTION_KEY: str = Field("api-mgmt-dev-subscription-key")
    APP_REG_CLIENT_SCOPE_INT_TESTS: str = Field("api://e22b013c-a202-4153-bd24-5ad3b62d1d6e/.default")
    TABLESTORAGE_TABLE_ODX: str = Field(
        "tblsgmlifdevweus"
    )
    TABLESTORAGE_ACCOUNT: str = Field("sttblcaa090")

class IntegrationTestQAConfiguration(IntegrationTestBaseConfiguration):
    BSCAN_API_URL: str = Field("https://qa-aixs.zeiss.com/bscanofinterest")
    INTEGRATION_TEST_APP_REG_CLIENT_ID = Field("integration-tests-client-id-mlws-weus-qa")
    INTEGRATION_TEST_APP_REG_CLIENT_SECRET = Field("integration-tests-client-secret-mlws-weus-qa")
    SUBSCRIPTION_KEY: str = Field("api-mgmt-qa-subscription-key")
    APP_REG_CLIENT_SCOPE_INT_TESTS: str = Field("api://app-mlws-weus-qa-integration-test/.default")
    TABLESTORAGE_TABLE_ODX: str = Field(
        "tblsgmlifqaweus"
    )
    TABLESTORAGE_ACCOUNT: str = Field("sttbla3e0e1")

class IntegrationTestStageConfiguration(IntegrationTestBaseConfiguration):
    BSCAN_API_URL: str = Field("https://stage-aixs.zeiss.com/bscanofinterest")
    INTEGRATION_TEST_APP_REG_CLIENT_ID = Field("integration-tests-client-id-mlws-weus-stage")
    INTEGRATION_TEST_APP_REG_CLIENT_SECRET = Field("integration-tests-client-secret-mlws-weus-stage")
    SUBSCRIPTION_KEY: str = Field("api-mgmt-stage-subscription-key")
    APP_REG_CLIENT_SCOPE_INT_TESTS: str = Field("api://app-mlws-weus-stage-integration-test/.default")
    TABLESTORAGE_TABLE_ODX: str = Field(
        "tblsgmlifstageweus"
    )
    TABLESTORAGE_ACCOUNT: str = Field("sttble4d4ab")


class ConfigurationFactory:
    def __call__(self):
        configuration = None
        environment: str = os.environ.get("ENV_STATE")
        if environment == "local":
            logging.info("Setting up configuration for local environment...")
            configuration = IntegrationTestLocalConfiguration()
        elif environment == "dev":
            logging.info("Setting up configuration for DEV environment...")
            configuration = IntegrationTestDevConfiguration()
        elif environment == "qa":
            logging.info("Setting up configuration for QA environment...")
            configuration = IntegrationTestQAConfiguration()
        elif environment == "stage":
            logging.info("Setting up configuration for Stage environment...")
            configuration = IntegrationTestStageConfiguration()
        else:
            raise KeyError("No environment set or environment not supported. Please set the environment variable" + 
                           f" 'ENV_STATE' to one of 'local', 'dev', 'qa' or 'stage'. Given: '{environment}'")
        
        return configuration


integration_test_configuration = ConfigurationFactory()()
