#!/bin/bash

image_name="nginx"
image_tag="1.21.6-alpine"

docker build -t "$image_name:$image_tag" .

if [ $? -eq 0 ]; then
  echo "Docker image '$image_name:$image_tag' was successfully build with Dockerfile."

else
  echo "Failed to build docker image '$image_name:$image_tag'. Dockerfile"
  exit 1
fi

compose_file="/home/aakash/capstoneproject/devops-build/build/docker-compose.yml"

docker-compose -f "$compose_file" build

if [ $? -eq 0 ]; then
  echo "Docker image '$image_name:$image_tag' build successfully using the $compose_file"
else
  echo "Failed to build docker images using $compose_file."
  exit 1
fi  
