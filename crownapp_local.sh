#!/bin/bash

# This script installs application dependencies on Darwin or Linux to run crownapp locally.

# Check if system is Darwin
if [ "Darwin" == "$(uname -s)" ]
then
  echo -e "\n==== Darwin system present ====\n"
  echo -e "\n==== Beginning dependency install for Darwin ====\n"
  # Install homebrew
  if ( which brew > /dev/null ) 
  then
    echo -e "\n==== Brew installed ====\n"
  else 
    echo -e "\n==== Installing brew ====\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install NodeJS on Mac
  if ( which node > /dev/null; ) 
  then
    echo -e "\n==== NodeJS present ====\n"
  else 
    echo -e "\n==== Installing NodeJS ====\n"
    brew install node 
  fi

  # Install NPM and its dependencies
  if [ -d node_modules ] 
  then
    echo -e "\n==== Node_modules installed ====\n"
  else 
    echo -e "\n==== Installing node_modules ====\n"
    npm install 
  fi

  npm start

  elif [ "Linux" == "$(uname -s)" ]
  then
    echo -e "\n==== Linux system present ====\n"
    echo -e "\n==== Starting dependency install for Linux ====\n"
    # Install NodeJS setup
    if ( which node > /dev/null; ) 
    then
      echo -e "\n==== NodeJS setup present ====\n"
    else 
      echo -e "\n==== Installing NodeJS setup ====\n"
      curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
      sudo apt install -y nodejs  
    fi

    # Install NPM and its dependencies
    if [ -d node_modules ] 
    then
      echo -e "\n==== Node_modules installed ====\n"
    else 
      echo -e "\n==== Installing node_modules ====\n"
      npm install 
    fi

    npm start

else
  # If user is not supported
  echo -e "\n\033[31m Unsupported Platform\033[0m\n"
fi



echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "