from behave import *

from configuration import integration_test_configuration


@given('Url "{url_endpoint_configuration}" for request')
def shared_url_endpoint(context, url_endpoint_configuration):
    context.service_url = getattr(integration_test_configuration, url_endpoint_configuration)
