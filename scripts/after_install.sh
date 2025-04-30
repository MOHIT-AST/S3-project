#!/bin/bash

# Optional: Log what we're doing
echo "Stopping all running Docker containers..."
docker stop $(docker ps -q) || true

echo "Removing all containers..."
docker rm $(docker ps -a -q) || true

echo "Pulling latest image from ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 688567295390.dkr.ecr.us-east-1.amazonaws.com

docker pull 688567295390.dkr.ecr.us-east-1.amazonaws.com/mayank:latest

echo "Running new container..."
docker run -d --name chat-app -p 3000:3000 688567295390.dkr.ecr.us-east-1.amazonaws.com/mayank:latest
