#!/bin/bash

# Parse the command line arguments. Usage: sh create-passwords-for-acr-tokens.sh -a acr_name -v keyvault_name -r first_repo -r second_repo
while getopts "a:v:r:" opt; do
  case $opt in
    a)
      acr_name=$OPTARG
      ;;
    v)
      vault_name=$OPTARG
      ;;
    r)
      repository_names+=("$OPTARG")
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

# Generate credentials for each repository and store the password in the keyvault
for repository_name in ${repository_names[@]}
do 
  echo "###"
  echo "Generating credentials and storing them to the keyvault for $repository_name"
  echo "###"
  echo "Generating password for token (make sure to run the infrastructure pipeline to create the token and scope man before running this pipeline)..."
  test_acr=`az acr token credential generate -n "acr-token-acr-scope-map-$repository_name" -r $acr_name --password1 --expiration-in-days 30` || exit 1
  echo "Generated token credential successfully."
  echo "---"
  echo "Parsing acr result"
  acr_token=`python3 -c "import sys, json, os; print(json.loads(sys.argv[1])['passwords'][0]['value']);" "$test_acr"` || exit 1
  echo "Successfully parsed acr results."
  echo "---"
  echo "Storing secret in keyvault $vault_name under $acr_name-$repository_name-token-password"
  az keyvault secret set --name "$acr_name-$repository_name-token-password" --vault-name $vault_name --value $acr_token --output none || exit 1
  echo "Stored secret successfully."
done