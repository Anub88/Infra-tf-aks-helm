#!/bin/bash

# Parse the command line arguments. 
# Usage: sh init-tf-backend.sh -e <environment> -r <region>
# Region should follow the azure standard, such as "westus".
while getopts "e:r:s:" opt; do
  case $opt in
    e)
      env=$OPTARG
      ;;
    r)
      region=$OPTARG
      ;;
    s)
      regionShortCode=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done



az group create -l westus -n rg-backend-$env-$regionShortCode-infra --tags env=$env

az storage account create -n stbackendtfdata$env -g rg-backend-$env-$regionShortCode-infra -l $region --sku Standard_LRS

az storage container create -n tf-state-container -g rg-backend-$env-$regionShortCode-infra --account-name stbackendtfdata$env --auth-mode login
