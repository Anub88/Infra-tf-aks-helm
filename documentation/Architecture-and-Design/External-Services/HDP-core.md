# Authentication

# ZeissID agreements

## HDP Environments

# Using HDP

- No rate-limit on HDP level implemented atm.

## Event stream

The event-stream response contains a resourceID that references the underlying id of, for example, an ImagingStudy object.

## Data retrieval

Multiple ImagingStudies can be downloaded at once.
One ImagingStudy represents one DICOM file.

## Data upload

DICOM files are always processed internally by HDP, regardless if they are uploaded via the DICOM API or the Data-Lake API.


# Testing

## Sandbox environment

To mock E2E flow:
- Post to /studies to upload mock dicom
- Request /event-stream
- Download ImagingStudy via resourceId
- Extract reference to original file
- Download original file
- Extract raw data from private tag


## Real device



