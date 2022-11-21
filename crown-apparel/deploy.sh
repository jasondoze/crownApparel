#!bin/bash

echo "crown app deploy..."

# this sets a timer
sudo true

# brew should be installed
if ( which brew > /dev/null ) 
then
  echo 'brew already installed'
else 
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# gnu-sed should be installed
if ( which gsed > /dev/null)
then
  echo 'sed already installed'
else
  brew install gnu-sed
fi

# multipass should be installed
if ( which multipass > /dev/null )
then 
  echo 'multipass already installed'
else
  brew install multipass
fi

# create an ssh key pair
if [ -f id_ed25519 ]
then 
  echo 'ssh key already generated'
else
  ssh-keygen -t ed25519 -N '' -f ./id_ed25519
fi

# add public key to cloud config yaml
if ( cat cloud-config.yaml | grep "$(cat id_ed25519.pub)" )
then 
  echo 'ssh key already added to cloud init'
else
  gsed -i "/ssh-ed25519/c\      - $(cat id_ed25519.pub)" cloud-config.yaml
fi

# check in the multipass list results for vm name and send to null
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo 'crown app vm already exists'
else 
  # create machine using user data
  multipass launch --name crownapp --cloud-init cloud-config.yaml
fi 

# copy up necessary files to production deploy
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'node_modules','.git','.gitignore','id_ed25519*','cloud-config.yaml'} $(pwd) jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}'):/home/jason  

# use ssh to execute a command on the remote vm
echo -e "\n==== executing install ===="
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 'cd crown-apparel && bash install.sh'   

# ssh into vm-  grep out the ip from multipass list $()
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') 

# make a new script install.sh 
# install node, npm, npm i, npm run build
# write the code to be item potent
# show that the app is running through the ip address
# before ssh in, 
# ssh into vm-  grep out the ip from multipass list $()

# write a system deservice that runs the app and enables it, how to write systemd for node
