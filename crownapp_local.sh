#!bin/bash

# This script performs the following tasks: installing application dependencies, building the application, transferring the systemd service file, and restarting the service.

echo -e "\n==== Beginning install ====\n"

# Install NodeJS
if ( which node > /dev/null; ) 
then
  echo -e "\n==== NodeJS setup present ====\n"
else 
  if [ "Darwin" == "$(uname -s)" ]
  then
    echo -e "You're on a Mac"
  elif [ "Linux" == "$(uname -s)" ]
  then
      echo -e "\n==== Installing NodeJS setup ====\n"
      curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
      sudo apt install -y nodejs  
  else
    echo -e "Unsupported platform"
  fi
fi

# Install NPM
if ( which npm ) 
then
  echo -e "\n==== NodeJS installed ====\n"
else 
  echo -e "\n==== Installing NodeJS && NPM && Update Browserlist ====\n"
  sudo apt install -y npm
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

echo -e "\n==== Install complete ====\n"

echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "