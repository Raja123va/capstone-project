#!/bin/bash

# Define variables
DOCKER_USER="raja123va"
DEV_REPO="dev"
PROD_REPO="prod"
IMAGE_NAME="react-app"
TAG="latest"

# Log in to Docker Hub
docker login -u "$DOCKER_USER" -p 'GLnP3,Wz5%7!cLN'

# Build the Docker image
docker build -t "$DOCKER_USER/$IMAGE_NAME:$TAG" .

# Get the branch name from Jenkins environment variable
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Check the branch and tag the image accordingly
if [ "$BRANCH_NAME" == "dev" ]; then
    # Tag the image for the dev repository
    docker tag "$DOCKER_USER/$IMAGE_NAME:$TAG" "$DOCKER_USER/$DEV_REPO:$TAG"
    # Push the image to the dev repository
    docker push "$DOCKER_USER/$DEV_REPO:$TAG"
elif [ "$BRANCH_NAME" == "master" ]; then
    # Tag the image for the prod repository
    docker tag "$DOCKER_USER/$IMAGE_NAME:$TAG" "$DOCKER_USER/$PROD_REPO:$TAG"
    # Push the image to the prod repository
    docker push "$DOCKER_USER/$PROD_REPO:$TAG"
else
    echo "This script only handles pushes to the dev and master branches."
    exit 1
fi
