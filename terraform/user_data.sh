#!/bin/bash
# Update packages and install prerequisites
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl

# Use Docker's official convenience script to install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add the ubuntu user to the docker group
sudo usermod -aG docker ubuntu

# --- Jenkins Setup ---
# Pull the Jenkins Docker Image
docker pull jenkins/jenkins:lts

# Create a Jenkins directory for persistent storage
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home

# Run Jenkins in a Docker container
docker run -d -p 8080:8080 -p 50000:50000 \
  --name jenkins \
  --restart=always \
  -v /var/jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts