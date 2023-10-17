# Notes
1. This document is preliminary for the purpose of beginning integration testing.
2. It will be replaced by a webpage that is currently beeing built.

# Authentication
Both endpoints require an oauth2 __bearer token__ and a __subscription key__. To retrieve the token do:

**URL** : `https://login.microsoftonline.com/82913d90-8716-4025-a8e8-4f8dfa42b719/oauth2/v2.0/token`

**Method** : `POST`

**Headers** : `Content-Type: application/x-www-form-urlencoded`

**Data**
All fields must be sent.
```
grant_type = client_credentials
scope = api://<<client_id>>/.default
client_id = {REDACTED}
client_secret = {REDACTED}"
```
## Success Response
**Code** : `200 OK`
```json
{
	"token_type": "Bearer",
	"expires_in": 3599,
	"ext_expires_in": 3599,
	"access_token": "{REDACTED}"
}
```
# Invoke ODX Inference

Invoke the ODX OCT B-scan of interest model.

**URL** : `https://qa-aixs.zeiss.com/func-orch-mlwf-qa-weus/mlorchestrator/inference/restevent`

**Method** : `POST`

**Headers** : 

    (required) Authorization: Bearer {REDACTED}
    (required) ocp-apim-subscription-key: {REDACTED}
    Content-Type: application/json
    x-platform-tenant-id: odx
    x-trace-id: 123
    x-hdp-tenant-id: someid
    x-model-reference-id: odxbscan
    x-model-version-id: 1.0

**Data**
```json
{
    // Json required by the odx model container
}
```

**Auth required** : YES

## Success Response

**Code** : `202 Accepted`

## Failure Response

**Code** : `400 Bad Request`

# Get ODX 
Retrieve ODX OCT B-scan of interest result via tenantId and examKey.
Note: The results are directly returned from the ODX container.

**URL** : `https://qa-aixs.zeiss.com/BScanOfInterest/{TenantId}/{examKey}`

**Method** : `GET`

**Headers** : 

    (required) Authorization: Bearer {REDACTED}
    Content-Type: application/json
    x-platform-tenant-id: odx
    x-trace-id: 123
    x-hdp-tenant-id: someid
    x-model-reference-id: odxbscan
    x-model-version-id: 1.0

## Success Response

**Code** : `200 OK`

**Data**
```json
[
  {
    "CalculatedSliceQuality": 0,
    "SliceFeedback": 0
  },
  {
    "CalculatedSliceQuality": 0,
    "SliceFeedback": 0
  },
  {
    "CalculatedSliceQuality": 0,
    "SliceFeedback": 0
  },
  {
    "CalculatedSliceQuality": 0,
    "SliceFeedback": 0
  },
  {
    "CalculatedSliceQuality": 2,
    "SliceFeedback": 0
  }
]
```

**Auth required** : YES
## Success Response - no data
**Code** : `404 Not Found`

## Failure Response
**Code** : `500 Internal Server Error`

