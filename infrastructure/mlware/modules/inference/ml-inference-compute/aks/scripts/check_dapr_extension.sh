#!/bin/bash
set -e
function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f $(which jq) || error_exit "{\"error\":\"jq command not detected in path, please install it\"}"
}
function check_dapr_extension() {
  eval "$(jq -r '@sh "RESOURCE_GROUP_NAME=\(.resource_group_name) AKS_NAME=\(.aks_name)"')"
  if [[ -z "${RESOURCE_GROUP_NAME}" ]]; then error_exit "{\"error\":\"resource_group_name is required\"}"; fi
  if [[ -z "${AKS_NAME}" ]]; then error_exit "{\"error\":\"aks_name is required\"}"; fi
  az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID > /dev/null || error_exit "{\"error\":\"az login failed\"}"
  az config set extension.use_dynamic_install=yes_without_prompt
  az extension add --name k8s-extension
  az k8s-extension list --resource-group ${RESOURCE_GROUP_NAME} --cluster-name ${AKS_NAME} --cluster-type managedClusters > extensions.log
  installed=$(jq '.[]| .scope.cluster.releaseNamespace == "dapr-system"' extensions.log) || error_exit "{\"error\":\"unable to fetch keys\"}"
  jq -n \
      --arg installed "$installed" \
      '{"dapr_installed":$installed}'

}
check_deps
check_dapr_extension



