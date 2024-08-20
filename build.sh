#!/bin/bash

docker login -u vasanth9999raja@gmail.com -p GLnP3,Wz5%7!cLN

def branchName = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
# Build the Docker image with a specific tag
docker build -t raja123va/react-app:latest .

# Tag the image for the dev repository
docker tag raja123va/react-app:latest raja123va/dev:latest

# Push the image to the dev repository on Docker Hub
docker push raja123va/dev:latest

