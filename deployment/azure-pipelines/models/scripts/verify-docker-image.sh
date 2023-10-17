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
if docker trust inspect $IMAGE_NAME:$IMAGE_TAG &> /dev/null; then
  DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $IMAGE_NAME:$IMAGE_TAG)

  if docker trust inspect ${DIGEST} >/dev/null 2>&1;then
  echo "Image ${IMAGE_NAME}:${IMAGE_TAG} is signed and trusted"
  else
  echo "Image ${IMAGE_NAME}:${IMAGE_TAG} is not signed and trusted"
  exit 1
  fi
else
  echo "Image ${IMAGE_NAME}:${IMAGE_TAG} is not signed and trusted"
  exit 1
fi
