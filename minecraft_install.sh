#!/bin/bash

# Remove old installs
sudo apt-get remove docker docker-engine docker.io containerd runc

# Make sure repos are up to date
sudo apt-get update

# Install requirements
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Get the docker gpg check
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the docker repo into the main repo list
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update with new repo
sudo apt-get update

# Install docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Setup directories
mkdir -p ~/mc/data

# Create launcher
echo "sudo docker run -d --rm -v ~/mc/data:/data -p 25565:25565 -e EULA=TRUE -e MEMORY=2G --name mc itzg/minecraft-server" > ~/run_minecraft.sh
chmod +x run_minecraft.sh
