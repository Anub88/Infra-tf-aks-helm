[[_TOC_]]

# Overview
Azure API Management is a hybrid, multicloud management platform for APIs across all environments. As a platform-as-a-service, API Management supports the complete API lifecycle.
The APIM goal is to allow organizations that create APIs or use others' APIs to monitor activity and ensure the needs of the developers and applications using the API are being met. Organizations are implementing strategies to manage their APIs so they can respond to rapid changes in customer demands.
Below is the reference to IaC code document used for provisioning and configuring the APIM provided by Hashicorp:
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management

In the current APIM setup OAuth2.0, Azure functions import, product and policies are implemented as part of automation. All these component has been separated as modules and are semi-automated (i.e; few steps are required to be carried out manually).

# APIM Provisioning:
## Pre-requisite
    Subnet Id - Subnet Id with external VNet type 
    Note: Basically we are using APIM to expose our API endpoints to public hence we need to interface APIM with our private network thats why we are using subnet ID.

## Custom Domain setup:
     Request for DNS - To setup custom domain for APIM we need DNS certificate along with SSL. 
    Once you have custom domain certificate. Please upload into keyvault under certificates.
    - Create the certificate by selecting import option
    - Provide name as "<env>-customdomain" ex: dev-customdomain, qa-customdomain
    - upload the .pfx file received for CustomDNS.
    - Provide the password of .pfx (shared by .pfx provider)

Make sure that, Upload of DNS Certificate in keyvault is done before you start configuration of custom domain.    
Custom domain can be configured in APIM In two ways 1) buy using apim settings in azure portal 2) By using terraform.

Using Azure Portal
Reference link: https://learn.microsoft.com/en-us/azure/api-management/configure-custom-domain?tabs=custom

Using Terraform   
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain 

Note:
The process of assigning the certificate may take 15 minutes or more depending on size of deployment. Developer tier has downtime, while Basic and higher tiers do not.
    
## Automation & Integration Documentation [Below are the procedure explaination]
###APIM creation
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management

(APIM) Module to provision the APIM resource, subnet id is required before creating the APIM. The above link demonstrate an example code for the same. 

###Authorization at APIM level
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_authorization_server
https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-protect-backend-with-aad
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy

OAuth for APIM is required for authorization of the client. This step implementation involves App registrations for all the subsequent client, enablement of Authorization server, credential configuration at APIM, and policy to validate JWT.
AD setup/configuration, subscription management and App registration are required to be manually done. Other than that Auth server setup, enabling Oauth, and policy to validate token using the Auth server are automate.

###Import Azure function
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value

Import function connects the function app to APIM as API. Before executing this module the function app must be created because openAPI spec is required for the app to create the API within APIM. If function app or OpenAPI spec for the app is not present the APIM will not be able to get the desired results rather terminate with 500 error response.

Here the function imports, adding backend to API's, and named values are automated. Uploading of openapi specification for the functions as .yml file to the blob storage, SAS token URL are to be manually done. 
Azure generates azure function host key with apim-{your apim instance name} during the manual import process which is then copied to APIM named value; Currently the automation for this is not available thats why it is required to be manually done.

###APIM Product
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api

(Product) This module creates an APIM product and attaches the API's to it. Product can be used to separate one client from another also if required specific policy can be set at product level as well. 


###APIM Policy
Reference link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy

(Policies) This module is to add policies at different scope within APIM. 
Currently OAuth (JWT validation) and CORS policy is being added at All API level, backend URL policy at the API level (i.e; to connect function app), and custom header at the API level (i.e; Required for one of the function App)
