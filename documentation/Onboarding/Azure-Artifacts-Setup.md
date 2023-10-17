[[_TOC_]]

A private package feed is set up to publish python packages for internal use in the AIXS project. The feed _mlware-python-feed_ is located [here](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_artifacts/feed/mlware-python-feed).

# Prerequisites
Python Packages
- artifacts-keyring
- twine
- wheel

The personal access token needs to include the scope of ``Packaging``.

# Authentication

The Azure DevOps Python package management uses _personal access tokens_ (**PAT**) for authentication. An authenticated ``pip install`` can be made: 

``pip install -r requirements.txt --index-url=https://mlware-python-feed:<azure-devops-personal-access-token>@pkgs.dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_packaging/mlware-python-feed/pypi/simple/``

Replace _<azure-devops-personal-access-token>_ with your PAT.

To use the feed for a specific virtual environment add a `pip.conf` (linux) or `pip.ini` (windows) file to your virtual environment with the extra index.
```
[global]
extra-index-url=https://mlware-python-feed:<YOUR-PAT-HERE>@pkgs.dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_packaging/mlware-python-feed/pypi/simple/
```

# Pulling and Publishing Artifacts
A description how to handle Python artifacts can be found [here](https://docs.microsoft.com/en-us/azure/devops/artifacts/quickstarts/python-packages?view=azure-devops). A description of basic connectivity is provided for:
- pulling Python artifacts: [via pip install](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_artifacts/feed/mlware-python-feed/connect/pip)
- publishing Python artifacts: [via twine](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_artifacts/feed/mlware-python-feed/connect/twine) (force override: --skip-existing)