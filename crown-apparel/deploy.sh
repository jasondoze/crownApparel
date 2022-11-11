#!bin/bash

echo "crown app deploy..."

sudo true

# brew should be installed
if ( which brew > /dev/null ) 
then
  echo 'brew already installed'
else 
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# add public key to cloud congig yaml
if ( cat cloud-config.yaml | grep "$(cat id_ed25519.pub)" )
then 
  echo 'ssh key already added to cloud init'
else
  sed -i "/ssh-ed25519/c \      - $(cat id_ed25519.pub)" cloud-config.yaml
fi

# check in the multipass list results for vm name and send to null
if ( multipass list | grep crownapp | grep Running > /dev/null ) 
then
  echo 'crown app vm already exists'
else 
  multipass launch --name crownapp --cloud-init cloud-config.yaml
fi 


# 1. create key 2. create config yaml 3. add pub key to config yaml 4. create machine using user data
##ssh-keygen -t ed25519 -N '' -f ./id_ed25519

#4. create machine using user data
#multipass launch -n crownapp --cloud-init cloud-config.yaml    

#5. ssh into vm  grep out the ip from multipass list $()
#`multipass list |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $3}'`
#192.168.64.9

ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')                                                                 
