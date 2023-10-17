# Overview
The MLware platform is exposing APIs to be consumed by AI product applications. The communication pattern between AI product applications and MLware platform is per default asynchronous and is using an event-based integration approach.

The inference API consists of two main operations:
- Inference request operation
- Inference results consumption

## Inference request operation
The inference request operation is triggering an inference process on MLware platform.

## Inference results consumption
The inference results consumption is providing means to consume inference results (produced by previously triggered inference request operation).

## API specification
The API specification is based on [AsyncAPI](https://www.asyncapi.com/), a standard for defining asynchronous APIs. The events specified implement the [CloudEvents specification](https://github.com/cloudevents/spec).

The MLware Inference API can be found [here](../.attachments/inference_external_event_api.yml). The API specification can be visualized using [AsyncAPI Studio](https://studio.asyncapi.com/?url=https://raw.githubusercontent.com/asyncapi/asyncapi/v2.2.0/examples/simple.yml).