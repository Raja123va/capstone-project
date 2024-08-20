#!/bin/bash


# Pull the latest image from Docker Hub
docker pull raja123va/${dev}:latest

# Stop and remove the existing container (if any)
docker stop react-app || true
docker rm react-app || true

# Run the container with the latest image
docker run -d --name react-app -p 80:80 raja123va/${dev}:latest

