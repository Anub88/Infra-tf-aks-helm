#!/bin/bash

# Parse the command line arguments. Usage: sh scan-docker-image-linux.sh -n image_name -t image_tag
while getopts "n:t:" opt; do
  case $opt in
    n)
      IMAGE_NAME=$OPTARG
      ;;
    t)
      IMAGE_TAG=$OPTARG
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

# Make sure that the image is not run with the root user
export INSPECT_IMAGE=$(docker inspect acrpubmlwscicdweus.azurecr.io/$IMAGE_NAME:$IMAGE_TAG)
# In the JSON output, the Config.user field must not be empty, otherwise, it will default to the "root" user, which might be dangerous.
echo $INSPECT_IMAGE

if echo $INSPECT_IMAGE | jq -r '.[] | .Config.User' | grep ".+"; then
  echo "User found for image, check successful."
else
  echo "ERROR: Since no user is defined, root access will be used. Please change that in the image."
  exit 1
fi

# TRIVY SCAN

docker pull aquasec/trivy:0.34.0

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.34.0 \
    image acrpubmlwscicdweus.azurecr.io/${IMAGE_NAME}:${IMAGE_TAG} >> scan_out.txt

# Show the scan result in the console
cat scan_out.txt
# Return error if there is a high or critical severity level
if grep -E "(HIGH|CRITICAL): [^0]" scan_out.txt; then
  echo "ERROR: found at least one high or critical vulnerability."
  exit 1
fi