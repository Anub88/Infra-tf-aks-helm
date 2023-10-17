## AI Model Package
In order to efficiently operate an AI model within the MLware platform, the AI model needs to comply with a specific standard. That standardization enables to build, deploy, validate, and even retire an AI solution (covering full AI solution lifecycle) in an efficient way.

The AI model needs to be packaged including its own runtime environment (for AI inference), expose a web interface for invoking inference and therefore needs to be deployed as webservice/microservice.

### AI Model web API
The AI model/solution needs to comply with a specific web/REST API specification. A very common standard is the [OpenAPI Specification](https://swagger.io/specification/), short OAS, which is going to be used here. The OpenAPI Specification defines a standard interface for specifically RESTful APIs.

A REST API is the default to be exposed for triggering inference processes within the AI model. Apart from this functional interface, the AI solution needs to expose certain administrative (e. g. health monitoring) APIs.

***Example of REST API specification:***
[openapi_model_webapi.yml](../.attachments/openapi_model_webapi.yml)
                           
*Note: The [openapi_model_webapi.yml](../.attachments/openapi_model_webapi.yml) can be visualized using [swagger editor](https://editor.swagger.io/).*

### AI Model Metadata
As part of the AI model package, a metadata description is required to provide details about the context and intended usage of the AI model solution. This contextual description of an AI model solution serves the purpose of mapping inference data to a best-fitting AI model for inference to achieve highest inference performance and quality.

***Example of model metadata file:***
[inference_metadata_model.yml](../.attachments/inference_metadata_model.yml)

## Gold Standard
In order to validate (and test) the AI model solution on a functional basis (Does the AI model perform as intended given a benchmark dataset?), a gold standard is required and needs to be applied to determine performance/quality metrics.