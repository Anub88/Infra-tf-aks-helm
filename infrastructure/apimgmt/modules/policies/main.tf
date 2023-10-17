resource "azurerm_api_management_policy" "auth_policy" {
  api_management_id = var.api_management_id
  xml_content       = <<XML
    <policies>
        <inbound>
            <cors allow-credentials="true">
            <allowed-origins>
                <origin>https://${var.api_management_name}.developer.azure-api.net</origin>
            </allowed-origins>
            <allowed-methods preflight-result-max-age="300">
                <method>*</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
            <expose-headers>
                <header>*</header>
            </expose-headers>
        </cors>
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized, Access token is missing or invalid">
            <openid-config url="${var.openid_config_url}" />
            <audiences>
                <audience>${var.auth_client1}</audience>
                <audience>${var.auth_client2}</audience>
            </audiences>
        </validate-jwt>
        <choose>
            <when condition="@(context.Request.Method != "GET" && context.Request.Headers.GetValueOrDefault("Content-Type") != "application/json")">
                <validate-content unspecified-content-type-action="prevent" max-size="102400" size-exceeded-action="detect" errors-variable-name="requestBodyValidation">
                    <content type="application/json" validate-as="json" action="detect" allow-additional-properties="true" />
                </validate-content>
                <return-response>
                    <set-status code="415" reason="Unsupported content Type" />
                    <set-body>{
                                "error": "Invalid Content-Type. Only 'application/json' is allowed."
                            }</set-body>
                </return-response>
            </when>
        </choose>
        <rate-limit-by-key  calls="${var.rate_limit_by_key_policy.calls}"
                                renewal-period="${var.rate_limit_by_key_policy.renewel_period}"
                                increment-condition="${var.rate_limit_by_key_policy.increment-condition}"
                                counter-key="${var.rate_limit_by_key_policy.counter-key}"
                                remaining-calls-variable-name="${var.rate_limit_by_key_policy.remaining-calls-variable-name}"/>
        <quota-by-key calls="${var.quota_by_key_policy.calls}"
                      renewal-period="${var.quota_by_key_policy.renewel_period}"
                      increment-condition="${var.quota_by_key_policy.increment-condition}"
                      counter-key="${var.quota_by_key_policy.counter-key}" />
        </inbound>
        <backend>
            <forward-request />
        </backend>
    </policies>
  XML
}

resource "azurerm_api_management_api_operation_policy" "header_policy" {
  for_each = {
    for key, value in var.func_names_list : key => value
    if value["header"]
  }
  api_name            = each.key
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = each.value.operationId

  xml_content = <<XML
    <policies>
        <inbound>
            <base />
            <!--  Don't expose APIM subscription key to the backend. -->
            <set-variable name="UTCNow" value="@(DateTime.Now.ToString("R"))" />
            <set-header name="ce-id" exists-action="skip">
                <value>8</value>
            </set-header>
            <set-header name="ce-source" exists-action="skip">
                <value>basiccarebsitest</value>
            </set-header>
            <set-header name="ce-type" exists-action="skip">
                <value>com.bsi.create</value>
            </set-header>
            <set-header name="ce-specversion" exists-action="skip">
                <value>1.0</value>
            </set-header>
            <set-header name="ce-time" exists-action="skip">
                <value>@( context.Variables.GetValueOrDefault<string>("UTCNow") )</value>
            </set-header>
            <set-header name="x-trace-id" exists-action="skip">
                <value>@( context.Variables.GetValueOrDefault<string>("UTCNow") )</value>
            </set-header>
            <set-header name="x-platform-tenant-id" exists-action="skip">
                <value>odx_123</value>
            </set-header>
            <set-header name="x-hdp-tenant-id" exists-action="skip">
                <value>some-hdp-tenant-id</value>
            </set-header>
            <set-header name="x-model-reference-id" exists-action="skip">
                <value>bsc-bscanofinterest</value>
            </set-header>
            <set-header name="x-model-version-id" exists-action="skip">
                <value>1.0.0</value>
            </set-header>
            <!--  Don't expose APIM subscription key to the backend. -->
            <set-header name="Ocp-Apim-Subscription-Key" exists-action="delete" />
        </inbound>
    </policies>
  XML
}

