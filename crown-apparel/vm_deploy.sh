#!/bin/bash

# This script automates the installation, setup and deployment of a virtual machine named "crownapp". It first installs required software such as Homebrew, gSed, and Multipass. Then it creates an SSH key pair, adds the public key to a cloud config file, and launches a Multipass VM. The script then transfers necessary files to the VM, installs Docker and runs a Docker container on the remote machine. Finally, it uses SSH to login to the VM.

echo "==== Begin crownapp deploy ===="

# The default password prompt timeout for the sudoers security policy is 5 minutes
sudo true

# Install homebreww
if ( which brew > /dev/null ) 
then
  echo -e "\n==== Brew installed ====\n"
else 
  echo -e "\n==== Installing brew ====\n"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install gnu-sed
if ( which gsed > /dev/null)
then
  echo -e "\n==== gSed installed ====\n"
else
  echo -e "\n==== Installing gSed ====\n"
  brew install gnu-sed
fi

# Install multipass
if ( which multipass > /dev/null )
then 
  echo -e "\n==== Multipass installed ====\n"
else
  echo -e "\n==== Installing Multipass ====\n"
  brew install multipass
fi

# # Install docker for local image build
# if ( which docker > /dev/null )
# then 
#   echo -e "\n==== Docker installed ====\n"
# else
#   echo -e "\n==== Installing and opening Docker desktop ====\n"
#   brew install docker
# fi

# Create an SSH key pair
if [ -f id_ed25519 ]
then  
  echo -e "\n==== SSH key present ====\n"
else
  echo -e "\n==== Creating SSH key pair ====\n"
  ssh-keygen -t ed25519 -N '' -f ./id_ed25519
fi

# Add public key to cloud config yaml
if ( cat cloud-config.yaml | grep "$(cat id_ed25519.pub)" )
then 
  echo -e "\n==== SSH key present ====\n"
else
  echo -e "\n==== Adding SSH key to cloud init  ====\n"
  gsed -i "/ssh-ed25519/c\      - $(cat id_ed25519.pub)" cloud-config.yaml
fi

# Launch multipass VM named crown app using cloud-init yaml file
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo -e "\n==== Crownapp VM present ====\n"
else 
  echo -e "\n==== Creating crownapp VM ====\n"
  multipass launch --cpus 4 --memory 7G --disk 50G --name crownapp --cloud-init cloud-config.yaml jammy
fi 

# Copy necessary files to production deploy using Rsync
echo -e "\n==== Transferring files to VM ====\n"
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'crownapp.service','netlify/','node_modules','.git','.gitignore','id_ed25519*','cloud-config.yaml'} $(pwd) jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '  {print $2}'):/home/jason 

# Use SSH to install Docker on the remote VM
echo -e "\n==== Executing install script ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' |  awk '{print $2}') 'cd crown-apparel && bash docker_install.sh'

# Check if the container exists
if ( docker container ls --all --quiet --filter "name=crown-apparel-container" | grep . > /dev/null )
then
  echo -e "\n==== Deleting existing crown-apparel-container ====\n"
  docker container stop crown-apparel-container
  docker container rm crown-apparel-container
else
  echo -e "\n==== No crown-apparel-container exists ====\n"

fi

# Build and run the container
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd crown-apparel && sudo docker build -t crown-apparel-image . && sudo docker run -d -p 3000:3000 --env-file .env --name crown-apparel-container crown-apparel-image'

# Use SSH to build Docker image and run the crownapp container on the remote VM
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd crown-apparel && sudo docker build -t crown-apparel-image . && sudo docker run -d -p 3000:3000 --env-file .env --name crown-apparel-container crown-apparel-image'

# ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd crown-apparel && bash nodejs_install.sh'

# SSH into VM
echo -e "\n==== SSH into VM ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')

