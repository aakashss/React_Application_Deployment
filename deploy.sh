#!/bin/bash
source build.sh

container_name="nginx-prod01"

#docker pull "$image_name:$image_tag"

if [ "$(docker ps -q -f name=$container_name)" ]; then
  echo "Stopping the container"
  docker stop "$container_name"
fi

if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
  echo "Removing the container..."
  docker rm "$container_name"
fi

docker run -dp 8083:80 --name "$container_name" "$image_name:$image_tag"

if [ "$(docker ps -q -f name=$container_name)" ]; then
  echo "Container '$container_name' is now running"
else
  echo "Failed to start container"
  exit 1
fi

container_name_2="nginx-prod02"
docker-compose -p "$container_name_2" up -d
if [ $? -eq 0 ]; then
  echo "Containers deployed Successfully"
else
  echo "Failed to deploy containers..."
  exit 1
fi
