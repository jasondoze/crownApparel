#!bin/bash

# This script facilitates the deployment process by performing the following actions: installing necessary dependencies, creating a virtual machine, transferring files to the virtual machine, executing an installation script within the virtual machine, and accessing the virtual machine via SSH

echo "==== Begin crownapp deploy ===="

# The default password prompt timeout for the sudoers security policy is 5 minutes
sudo true

# Brew should be installed
if ( which brew > /dev/null ) 
then
  echo -e "\n==== Brew installed ====\n"
else 
    echo -e "\n==== Installing brew ====\n"

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Gnu-sed should be installed
if ( which gsed > /dev/null)
then
  echo -e "\n==== gSed installed ====\n"
else
  echo -e "\n==== Installing gSed ====\n"
  brew install gnu-sed
fi

# Multipass should be installed
if ( which multipass > /dev/null )
then 
  echo -e "\n==== Multipass installed ====\n"
else
  echo -e "\n==== Installing multipass ====\n"
  brew install multipass
fi

# Create an ssh key pair
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

# Launch multipass VM named crown app using cloud init yaml file
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo -e "\n==== Crownapp VM present ====\n"
else 
  echo -e "\n==== Creating crownapp VM ====\n"
  multipass launch --cpus 2 --mem 2G --name crownapp --cloud-init cloud-config.yaml
fi 

# Copy necessary files to production deploy using Rsync
echo -e "\n==== Transferring files to VM ====\n"
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'build','node_modules','.git','.gitignore','id_ed25519*','cloud-config.yaml'} $(pwd) jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}'):/home/jason  

# Use SSH to execute commands on the remote VM
echo -e "\n==== Executing install script ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd ~/crown-apparel && bash multipass_install.sh'  

# SSH into VM
echo -e "\n==== SSH into VM ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 