#!/bin/bash
# destroy machine and delete fingerprint

# remove host from known host
if ( ssh-keygen -H -F $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') ) 
then
  echo 'deleting host from known host'
  ssh-keygen -f ~/.ssh/known_hosts -R $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')
else 
  echo 'fingerprint does not exist in known host'
fi 

# only delete the machine if it exists
if ( multipass info crownapp > /dev/null ) 
then
  echo 'deleting crown app machine'
  multipass delete crownapp && multipass purge
else 
  echo 'crownapp machine does not exist'
fi 

# delete an ssh key pair
if [ -f id_ed25519 ]
then 
  echo 'remove ssh key'
  rm id_ed25519 id_ed25519.pub
else
  echo 'no keys present'
fi

