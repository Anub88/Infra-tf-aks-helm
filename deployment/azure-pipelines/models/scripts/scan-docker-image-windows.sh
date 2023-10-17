
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

echo "The scan is skipped since the windows build agent doesn't work"

# This only works on a windows machine. 
# TODO scan windows image from the windows build agent
# TODO uncomment the following lines

# Make sure that the image is not run with the root user
# export INSPECT_IMAGE=$(docker inspect acralgomlwsdevweus.azurecr.io/$IMAGE_NAME:$IMAGE_TAG)
# In the JSON output, the Config.user field must not be empty, otherwise, it will default to the "root" user, which might be dangerous.
# echo $INSPECT_IMAGE

# if echo $INSPECT_IMAGE | jq -r '.[] | .Config.User' | grep ".+"; then
#   echo "User found for image, check successful."
# else
#   echo "ERROR: Since no user is defined, root access will be used. Please change that in the image."
#   exit 1
# fi

# TODO DOCKER SCAN
# docker scan $IMAGE_NAME:$IMAGE_TAG
# The output will list the number of vulnerabilities found