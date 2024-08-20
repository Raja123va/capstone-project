#!/bin/bash

# Define variables
DOCKER_USER="raja123va"
DEV_REPO="dev"
PROD_REPO="prod"
IMAGE_NAME="react-app"
TAG="latest"

# Pull the latest image from Docker Hub
docker pull $DOCKER_USER/$IMAGE_NAME:$TAG

# Stop and remove the existing container (if any)
docker stop react-app || true
docker rm react-app || true

# Run the container with the latest image
docker run -d --name react-app -p 80:80 $DOCKER_USER/$IMAGE_NAME:$TAG

