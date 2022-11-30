#!bin/bash

echo "Crownapp deploy..."

# this sets a timer
sudo true

# brew should be installed
if ( which brew > /dev/null ) 
then
  echo -e "\n==== Brew already installed ===="
else 
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# gnu-sed should be installed
if ( which gsed > /dev/null)
then
  echo -e "\n==== gSed already installed ===="
else
  brew install gnu-sed
fi

# multipass should be installed
if ( which multipass > /dev/null )
then 
  echo -e "\n==== Multipass already installed ===="
else
  brew install multipass
fi

# create an ssh key pair
if [ -f id_ed25519 ]
then  
  echo -e "==== SSH key already generated ====\n"
else
  echo -e "\n==== Creating ssh key pair ===="
  ssh-keygen -t ed25519 -N '' -f ./id_ed25519
fi

# add public key to cloud config yaml
if ( cat cloud-config.yaml | grep "$(cat id_ed25519.pub)" )
then 
  echo -e "\n==== SSH key already added to cloud init ===="
else
  echo -e "\n==== Adding public key to cloud config yaml file ===="
  gsed -i "/ssh-ed25519/c\      - $(cat id_ed25519.pub)" cloud-config.yaml
fi

# check in the multipass list results for vm name and send to null
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo -e "\n==== Crownapp vm already exists ===="
else 
  # create machine using user data
  echo -e "\n==== Creating crownapp vm ====\n"
  multipass launch --cpus 2 --mem 2G --name crownapp --cloud-init cloud-config.yaml
fi 

# copy up necessary files to production deploy
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'build','node_modules','.git','.gitignore','id_ed25519*','cloud-config.yaml'} $(pwd) jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}'):/home/jason  

# use ssh to execute a command on the remote vm
echo -e "\n==== Executing install ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd ~/crown-apparel && bash install.sh'  

# ssh into vm-  grep out the ip from multipass list $()
echo -e "\n==== SSH into vm ===="
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 