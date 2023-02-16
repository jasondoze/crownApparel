#!/bin/bash

# This code checks and installs Docker on an Ubuntu-based system. It does this by checking if the Docker executable, Docker repository, and the Docker engine packages are present and installing them if they are not.

# Add Docker’s GPG key
if ( which docker > /dev/null) 
then
  echo -e "\n==== Docker installed ====\n"
else
  echo -e "\n==== Installing Docker ====\n"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

# Set up the Docker repository
if [ -f /etc/apt/sources.list.d/docker.list ]
then
  echo -e "\n==== Docker repository present ====\n"
else
  echo -e "\n==== Creating Docker repository ====\n"
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# Install Docker engine, containerd, docker compose & update the apt package index
if (which docker-ce && which docker-ce-cli && which containerd.io && which docker-compose-plugin)
then
  echo -e "\n==== Docker engine packages present ====\n"
else
  echo -e "\n==== Installing Docker engine packages ====\n"
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

