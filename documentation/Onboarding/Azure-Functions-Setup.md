# Setup
Since Azure Functions for Python is only supported (as runtime constraint) on **Linux**, a Linux host or Linux subsystem is required for testing Azure Functions for Python locally.
See the [official microsoft site](https://learn.microsoft.com/de-de/windows/wsl/install) for setting up a WSL (Windows Subsytem for Linux). 

Ensure you have a working python **3.9** environment on your system.

Install the packages 
- artifacts-keyring, twine and wheel (see Package Managment in this Wiki).

Then install the
- [Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Clinux%2Ccsharp%2Cportal%2Cbash#v2)
- and the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli). 


### TODO
Add a description how to test functions that are behind a VNet.

# VS Code Configuration

For editing existing Azure Functions open the root directory of the function app (contains _host.json_) in VSCode. Accept the prompt to initialize the function project with VSCode, this **should** create all necessary files for running/debugging locally.

If this is not the case use the example configuration below.

Place in the root directory of your Azure Functions project the following VS Code configuration files (to be put into ``.vscode`` directory):

``launch.json:``  
````
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Attach to Python Functions",
            "type": "python",
            "request": "attach",
            "port": 9091,
            "preLaunchTask": "func: host start"
        }
    ]
}
````

``settings.json:``

````
{
    "python.defaultInterpreterPath": ".venv/bin/python3",
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true,
    "python.testing.pytestPath": ".venv/bin/pytest",
    "python.testing.autoTestDiscoverOnSaveEnabled": true,
    "python.testing.pytestArgs": [
        "./client_docker/tests",
        "./client_inference_data/tests",
        "./client_keyvault/tests",
        "./mlwarefoundation/tests",
        "./service_data_access/tests",
        "./service_historical_data_retrieval/tests",
        "./service_model_lookup/tests",
        "./workflow_engine_chain/service_event_starter/tests",
        "./workflow_engine_chain/service_http_starter/tests",
        "./workflow_engine_chain/service_model_data_mapping/tests",
        "./workflow_engine_chain/service_model_invocation/tests"
    ],
    "python.envFile": "${workspaceFolder}/.env",
    "python.formatting.provider": "black",
    "behave-vsc.featuresPath": "integration_tests/applications/features",
    "azureFunctions.scmDoBuildDuringDeployment": true,
    "azureFunctions.pythonVenv": "${workspaceFolder}/.venv",
    "azureFunctions.projectLanguage": "Python",
    "azureFunctions.projectRuntime": "~4",
    "python.linting.pylintEnabled": true,
    "python.linting.lintOnSave": true,
    "python.linting.enabled": true,
    "python.linting.pylintPath": ".venv/bin/pylint",
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true
    },
    "pythonTestExplorer.testFramework": "pytest",
    "azureFunctions.projectSubpath": "<function-name>"
}
````
Note, that the placeholder <function-name> needs to be exchanged with the name of the folder containing the (set) of functions, ex. workflow_engine_chain.


``tasks.json:``

````
{
  "version": "2.0.0",
  "tasks": [
    {
      "type": "func",
      "command": "host start",
      "problemMatcher": "$func-python-watch",
      "isBackground": true,
      "dependsOn": "pip install (functions)",
      "options": {
        "cwd": "${workspaceFolder}/<function-name>"
      }
    },
    {
      "label": "pip install (functions)",
      "type": "shell",
      "osx": {
        "command": "${config:azureFunctions.pythonVenv}/bin/python -m pip install -r requirements.txt"
      },
      "windows": {
        "command": "${config:azureFunctions.pythonVenv}/Scripts/python -m pip install -r requirements.txt"
      },
      "linux": {
        "command": "${config:azureFunctions.pythonVenv}/bin/python -m pip install -r ${workspaceFolder}/<function-name>/requirements.txt"
      },
      "problemMatcher": []
    }
  ]
}
````
Note, that the placeholder <function-name> needs to be exchanged with the name of the folder containing the (set) of functions, which will be locally executed, ex. service_historical_data_retrieval.

Add a ``local.settings.json`` (required for local Azure Functions execution) in the root directory of your Azure Functions project:

````
{
    "IsEncrypted": false,
    "Values": {
      "FUNCTIONS_WORKER_RUNTIME": "python",
      "AzureWebJobsStorage": "UseDevelopmentStorage=true",
      "AzureWebJobsSecretStorageType": "files",
      "ENV_STATE": "local"
    }
}
````

