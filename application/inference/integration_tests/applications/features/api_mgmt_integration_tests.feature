Feature: Azure Kubernetes Service - GET and POST Method

    @b_scan_of_interest
    @api_management
    @get
    Scenario Outline: Test API Management GET Endpoint for B-Scan Of Interest with tenant id <TENANT_ID> and exam key <EXAM_KEY>
        Given Keyvault client is initialized
        Given Keyvault client retrieves client id for "INTEGRATION_TEST_APP_REG_CLIENT_ID" from key vault for app registration
        Given Keyvault client retrieves client secret for "INTEGRATION_TEST_APP_REG_CLIENT_SECRET" from key vault for app registration
        Given Keyvault client retrieves subscription key for "SUBSCRIPTION_KEY" from key vault for api management request
        Given Client secret credential authentication is initialized without errors
        Given OAuth2 token is received for client credential with scope "APP_REG_CLIENT_SCOPE_INT_TESTS"
        Given A GET request is initialized for B-Scan of Interest with exam key "<EXAM_KEY>" and tenant id "<TENANT_ID>"
        When A GET http request is sent to retrieve inference data
        Then The http response code is "<RESPONSE_CODE>"
        Then The get response body has the expected ODX format if the response has a body

        Examples:
            | EXAM_KEY                             | TENANT_ID | RESPONSE_CODE |
            | 9002edce-8c45-383e-b6be-201c1540c87d | 5020      | 200           |
            | invalid                              | invalid   | 400           |
            | 342991c0-b15d-442f-8016-9933a21f389b | invalid   | 404           |
            | invalid                              | 0129      | 400           |

    @b_scan_of_interest
    @api_management
    @post
    Scenario Outline: Test API Management POST Endpoint for B-Scan Of Interest with tenant id <TENANT_ID> and exam key <EXAM_KEY>
        Given Keyvault client is initialized
        Given Keyvault client retrieves client id for "INTEGRATION_TEST_APP_REG_CLIENT_ID" from key vault for app registration
        Given Keyvault client retrieves client secret for "INTEGRATION_TEST_APP_REG_CLIENT_SECRET" from key vault for app registration
        Given Keyvault client retrieves subscription key for "SUBSCRIPTION_KEY" from key vault for api management request
        Given Client secret credential authentication is initialized without errors
        Given OAuth2 token is received for client credential with scope "APP_REG_CLIENT_SCOPE_INT_TESTS"
        Given A POST endpoint for B-Scan Of Interest is initialized with cube "<CUBE>", cube volume "<CUBE_VOLUME>", tenant id "<TENANT_ID>" and exam key "<EXAM_KEY>"
        When A POST request is sent
        Then The http response code is "<RESPONSE_CODE>"

        Examples:
            | CUBE                                                                                                                                                                                              | CUBE_VOLUME                                                                                                                                                                                            | TENANT_ID         | EXAM_KEY                             | RESPONSE_CODE |
            | https://stbackendtfdataqa.blob.core.windows.net/cubedata/cube.bin?sp=r&st=2022-11-07T08:30:32Z&se=2023-04-30T16:30:32Z&spr=https&sv=2021-06-08&sr=b&sig=LmkBpWR59Kfnbh43%2FVCW04y8o0S6DAIRy6gmpAEOON4%3D | https://stbackendtfdataqa.blob.core.windows.net/cubedata/cube_volume.bin?sp=r&st=2022-11-07T08:29:36Z&se=2023-04-30T16:29:36Z&spr=https&sv=2021-06-08&sr=b&sig=rukUvtIbY3ch81duP7yfyDU169FtsfKNsS5yvZ88pZc%3D | 6543              | 73fb89c0-fd4c-4b02-bf42-a609b396a431 | 201           |
            | invalid cube                                                                                                                                                                                      | invalid cube volume                                                                                                                                                                                    | invalid tenant id | invalid exam key                     | 201           |