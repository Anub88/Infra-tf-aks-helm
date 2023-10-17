import json
import uuid
import requests
from behave import given, when, then
from configuration import integration_test_configuration
from environment import circuit_breaker

@given('A GET request is initialized for B-Scan of Interest with exam key "{exam_key}" and tenant id "{tenant_id}"')
def set_get_url(context, exam_key: str, tenant_id: str):
    context.apim_get_url = integration_test_configuration.BSCAN_API_URL + "/" + tenant_id + "/" + exam_key
    trace_id = uuid.uuid4()
    random_tenant_id = uuid.uuid4()
    context.headers = {
        "Authorization": f"Bearer {context.oauth2_token}",
        "Content-Type": "application/json",
        "x-platform-tenant-id":"odx",
        "x-trace-id": f"{trace_id}",
        "x-hdp-tenant-id": f"{random_tenant_id}",
        "x-model-reference-id" : "odx_bscan",
        "x-model-version-id" : "1.0",
        "Ocp-Apim-Subscription-Key" : f"{context.subscription_key}"
    }

@when('A GET http request is sent to retrieve inference data')
@circuit_breaker
def get_api_request(context):
    context.response = requests.get(
        url=context.apim_get_url,
        headers=context.headers
    )   

@then('The http response code is "{response_code}"')
def get_api_request_success(context, response_code):
    assert context.response is not None
    assert context.response.status_code == int(response_code), f"expected {response_code}, got {context.response.status_code}"
    
    
@given('A POST endpoint for B-Scan Of Interest is initialized with cube "{cube}", cube volume "{cube_volume}", tenant id "{tenant_id}" and exam key "{exam_key}"')
def post_api_initialized(context, cube, cube_volume, tenant_id, exam_key):
    context.apim_post_url = integration_test_configuration.BSCAN_API_URL
    assert context.apim_post_url is not None
    trace_id = uuid.uuid4()
    random_tenant_id = uuid.uuid4()
    context.headers = {
        "x-trace-id": f"{trace_id}",
        "x-platform-tenant-id":"odx",
        "x-hdp-tenant-id": f"{random_tenant_id}",
        "x-model-reference-id" : "odx_bscan",
        "x-model-version-id" : "1.0",
        "Content-Type" : "application/json",
        "Ocp-Apim-Subscription-Key" : f"{context.subscription_key}",
        "Authorization": f"Bearer {context.oauth2_token}",
        "Content-Type": "application/json"
    }
    context.payload = json.dumps(
        {
            "Cube": cube,
            "CubeVolume": cube_volume,
            "PatientID": "CZMI617134232",
            "Laterality": "Od",
            "AcquisitionDate": "3/6/2020 11:11:20 AM",
            "Population": "DIVERSE",
            "DateOfBirth": "07/04/1957 00:00:00",
            "TenantId": tenant_id,
            "ExamKey": exam_key,
            "grant_type" : "client_credentials"
        }
    )

@when('A POST request is sent')
@circuit_breaker
def send_post_api_request(context):
    context.response = requests.post(
        url=context.apim_post_url,
        headers=context.headers,
        data=context.payload
    ) 

@then('The get response body has the expected ODX format if the response has a body')
def check_response_body_get_odx(context):
    if context.response.status_code < 300:
        response_json = context.response.json()
        assert isinstance(response_json, list), f"Expected a list, got a {response_json.__class__.__name__}"
        for elem in response_json:
            assert "CalculatedSliceQuality" in elem.keys(), f"Key 'CalculatedSliceQuality' not found."
            assert "SliceFeedback" in elem.keys(), f"Key 'SliceFeedback' not found."
