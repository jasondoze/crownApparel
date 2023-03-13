#!/bin/bash

# This script installs application dependencies on Darwin or Linux to run crownapp locally and or via VM.

# Check if NodeJS is installed locally
if (which node > /dev/null)
then
  echo -e "\n==== NodeJS setup present ====\n"

  # Install CrownApp Dependencies
  if [ -d node_modules ]
  then
    echo -e "\n==== Node_modules installed ====\n"
  else
    echo -e "\n==== Installing node_modules ====\n"
    npm install
  fi
  # Run CrownApp locally
  npm start
else
   # Check if system is Darwin
  if [ "Darwin" == "$(uname -s)" ]
  then
    echo -e "\n==== Beginning dependency install for Darwin VM deploy ====\n"
    bash darwin_vmdeploy.sh
  # Check if system is Darwin
  elif [ "Linux" == "$(uname -s)" ]
  then
    echo -e "\n==== Beginning dependency install for Linux VM deploy ====\n"
    bash linux_vmdeploy.sh
  else
  # If platform is not Darwin or Linux
  echo -e "\n\033[31m Platform not supported \033[0m\n"
  fi
fi
