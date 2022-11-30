#!/bin/bash
# destroy machine and delete fingerprint

# remove host from known host
if ( ssh-keygen -H -F $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') ) 
then
  echo -e "\n==== Deleting host from known host ====\n"
  ssh-keygen -f ~/.ssh/known_hosts -R $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')
else 
  echo -e "\n==== Fingerprint does not exist in known host ====\n"
fi 

# only delete the machine if it exists
if ( multipass info crownapp > /dev/null ) 
then
  echo -e "\n==== Deleting crownapp machine ===="
  multipass delete crownapp && multipass purge
else 
  echo -e "\n==== Crownapp machine does not exist ===="
fi 

# delete an ssh key pair
if [ -f id_ed25519 ]
then 
  echo -e "\n==== Removing ssh key ====\n"
  rm id_ed25519 id_ed25519.pub
else
  echo -e "\n==== No keys present ====\n \n==== Destroy complete ====\n"
fi

