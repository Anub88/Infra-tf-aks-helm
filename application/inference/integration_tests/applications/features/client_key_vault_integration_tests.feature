Feature: Client Key Vault

@infrastructure.key_vault
@application.client.key_vault
Scenario: Azure Key Vault: Retrieval of secret for a given key
    Given Keyvault client is initialized for keyvault check
    When Keyvault client tries to retrieve key "integration-test-key" from key vault
    Then Secret is available as string

@infrastructure.key_vault
@application.client.key_vault
Scenario: Azure Key Vault: Retrieval of secret for a non-existing key
    Given Keyvault client is initialized for keyvault check
    When Keyvault client tries to retrieve key "somekeythatshouldnotexistsinkeyvaultanywhere" from key vault
    Then Secret is not available as string and exception is available


@infrastructure.key_vault
@application.client.key_vault
Scenario: Azure Key Vault: Retrieval of certificate for a given name
    Given Keyvault client is initialized for keyvault check
    When Keyvault client tries to retrieve name "integration-test-certificate" from key vault
    Then Certificate is available as object

@infrastructure.key_vault
@application.client.key_vault
Scenario: Azure Key Vault: Retrieval of certificate for a non-existing name
    Given Keyvault client is initialized for keyvault check
    When Keyvault client tries to retrieve name "somenamethatshouldnotexistsinkeyvaultanywhere" from key vault
    Then Certificate is not available as object and exception is available