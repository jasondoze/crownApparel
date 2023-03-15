#!/bin/bash

# This script installs application dependencies on Darwin or Linux to run crownapp locally and or via VM.
# This should work anywhere



# Check if NodeJS is installed locally
if ( which node > /dev/null )
then
  echo -e "\n==== NodeJS setup present ====\n"
else 
  echo -e "\n==== Installing NodeJS ====\n"
   # Check if system is Darwin
  if [ "Darwin" == "$(uname -s)" ]
  then
    echo -e "\n==== Install node for Darwin on MacOS ====\n"
    # The default password prompt timeout for the sudoers security policy is 5 minutes
    sudo true

    # Install homebreww
    if ( which brew > /dev/null ) 
    then
      echo -e "\n==== Brew installed ====\n"
    else 
      echo -e "\n==== Installing brew ====\n"
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node
  elif [ "Linux" == "$(uname -s)" ]
  then
    echo -e "\n==== Install node for Linux ====\n"
    curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
    sudo apt install -y nodejs 
  fi
fi

# Install NPM dependencies
if [ -d node_modules ] 
then
  echo -e "\n==== Node_modules installed ====\n"
else 
  echo -e "\n==== Installing node_modules ====\n"
  npm install 
fi

# Is the app running?
if ( curl localhost:3000 )
then 
  echo -e "\n==== CrownApp is started ====\n"
else
  if [ "Linux" == $(uname -s) ]
  then 
    echo -e "\n==== CrownApp is starting ====\n"
     # Copy service file and reload daemon
    if [ -f /lib/systemd/system/crownapp.service ] 
    then
      echo -e "\n==== Service file present ====\n"
    else 
      echo -e "\n==== Copying crownapp.service ====\n"
      sudo cp crownapp.service /lib/systemd/system/ && sudo systemctl daemon-reload
    fi
    
    # Potential npm build here

    # Restart the crownapp service
    if ( systemctl is-active crownapp.service ) 
    then
      echo -e "\n==== Crownapp running ====\n"
    else 
      echo -e "\n==== Starting crownapp ====\n"
      source .env
      sudo systemctl restart crownapp.service
    fi
  else
    echo -e "\n==== CrownApp is starting ====\n"
    npm start
  fi
fi

echo -e "\n==== Install complete ====\n"

echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "

