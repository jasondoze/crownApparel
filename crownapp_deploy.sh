#!/bin/bash

# This script performs the following tasks: installing application dependencies on Darwin.

echo -e "\n==== Beginning install ====\n"

# The default password prompt timeout for the sudoers security policy is 5 minutes
sudo true

# Check if system is a Mac
if [ "Darwin" == "$(uname -s)" ]
then


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

  # Install multipass
  if ( which multipass > /dev/null )
  then 
    echo -e "\n==== Multipass installed ====\n"
  else
    echo -e "\n==== Installing Multipass ====\n"
    brew install multipass
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

  echo -e "\n==== Local crownapp complete ====\n"

else
  # If user is not on a Mac system
  echo -e "\n\033[31m You shall not pass!!!\033[0m\n"
fi

echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "