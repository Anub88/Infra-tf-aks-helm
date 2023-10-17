# Monitoring
In order to detect failures in our systems or to find the errors in our logs or simply to have some usage statistics, azure and other frameworks provide important monitoring information. Here is a list of the monitoring capabilities that we currently have in place

## Azure Application insights
In order to detect failures, errors and more in our azure function execution, we are using Application Insights. In order to access it, you can simply go in the azure portal, search for your function, click on the Application Insights menu in the sidebar and click on "view application insights data".

## Azure Container insights
The AKS also provides a possibility to track and monitor container activities: Azure Container Insights. This can be accessed through the azure portal: search for your AKS cluster, click on the "Insights" menu in the sidebar (under Monitoring) and you'll see some metrics that can be adapted as desired.