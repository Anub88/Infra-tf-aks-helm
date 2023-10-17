Feature: Client Table Storage

@infrastructure.table_storage
@application.client.table_storage
Scenario Outline: Retrieval of inference data for tenant ids and exam keys <TENANT_ID_EXAM_KEY_DICT> from Azure Table Storage
    Given Table Storage client is initialized with table storage account "TABLESTORAGE_ACCOUNT" and "KV_TABLESTORAGE_KEY_ODX"
    When Table Storage client tries to retrieve data from table "TABLESTORAGE_TABLE_ODX" for tenant id and exam id <TENANT_ID_EXAM_KEY_DICT>
    Then "<MIN_NUMBER_OF_MATCHES>" elements are available from Table Storage

    Examples:
        | TENANT_ID_EXAM_KEY_DICT                                                                                | MIN_NUMBER_OF_MATCHES |
        | {"0129": "342991c0-b15d-442f-8016-9933a21f389b", "0128": "342991c0-b15d-442f-8016-9933a21f389b"}       | 1                     |
        | {"0129": "not-existing-exam-id"}                                                                       | 0                     |