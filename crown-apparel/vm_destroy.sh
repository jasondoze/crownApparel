#!/bin/bash

# This script carries out the following actions: terminating the virtual machine, removing the SSH key pair, and removing the virtual machine's fingerprint from the known host file.

# Delete Docker image
echo -e "\n==== Delete and purge images ====\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 jason@$(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' |  awk '{print $2}') 'docker rm -f $(docker ps -a -q) && sudo docker system prune --all -y' 

# Delete fingerprint from known_hosts
if ( ssh-keygen -H -F $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') ) 
then
  echo -e "\n==== Deleting fingerprint from known host ====\n"
  ssh-keygen -f ~/.ssh/known_hosts -R $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}')
else 
  echo -e "\n==== Fingerprint not present in known host ====\n"
fi 

# Delete the VM
if ( multipass info crownapp > /dev/null ) 
then
  echo -e "\n==== Deleting VM ====\n"
  multipass delete crownapp && multipass purge
else 
  echo -e "\n==== VM does not exist ====\n"
fi 

# Delete the SSH key pair
if [ -f id_ed25519 ]
then 
  echo -e "\n==== Deleting SSH key ====\n"
  rm id_ed25519 id_ed25519.pub
else
  echo -e "\n==== Keys deleted ====\n"
fi