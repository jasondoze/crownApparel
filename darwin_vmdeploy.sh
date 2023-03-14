#!/bin/bash

# This script facilitates the deployment process on Darwin by performing the following actions: installing necessary dependencies, creating a virtual machine, transferring files to the virtual machine, executing an installation script within the virtual machine, and accessing the virtual machine via SSH

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
if ( which gsed > /dev/null )
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

# Create an SSH key pair
if [ -f id_ed25519 ]
then  
  echo -e "\n==== SSH key present ====\n"
else
  echo -e "\n==== Creating SSH key pair ====\n"
  ssh-keygen -t ed25519 -N '' -f ./id_ed25519
fi

# Write out cloud-init yaml file to create for user and keys
if [ -f cloud-init.yaml ]
then 
  echo -e "\n==== Cloud-init.yaml is present ====\n"
else
  echo -e "\n==== Writing cloud-init.yaml  ====\n"
  cat <<- EOF > cloud-init.yaml
users:
  - default
  - name: $USER
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat id_ed25519.pub)
EOF
fi

# Launch multipass VM named crown app using cloud-init yaml file
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo -e "\n==== Crownapp VM present ====\n"
else 
  echo -e "\n==== Creating crownapp VM ====\n"
  multipass launch --cpus 4 --memory 7G --disk 50G --name crownapp --cloud-init cloud-init.yaml
fi 

# Copy necessary files to production deploy using Rsync
echo -e "\n==== Transferring files to VM ====\n"
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'.git','.gitignore','.netlify','netlify','node_modules','id_ed25519*','cloud-init.yaml'} $(pwd) $USER@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}'):/home/$USER 

# Use SSH to execute commands on the remote VM
echo -e "\n==== Executing install script ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 $USER@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd crownAppTypescript && bash nodejs_install.sh'

# SSH into VM
echo -e "\n==== SSH into VM ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 $USER@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')