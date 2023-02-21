#!bin/bash

# This script checks if NodeJS setup, NodeJS and NPM, and node_modules are installed and if not, it installs them. The code also checks if the NPM build has been completed, and if not, runs the NPM build.



echo -e "\n==== Beginning install ====\n"

# Add executable permissions to the script
chmod +x nodejs_install.sh

# Install NodeJS setup
if ( which nodejs > /dev/null; ) 
then
  echo -e "\n==== NodeJS setup present ====\n"
else 
  echo -e "\n==== Installing NodeJS setup ====\n"
  curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
fi

# Install NodeJS and NPM
if ( which node ) 
then
  echo -e "\n==== NodeJS installed ====\n"
else 
  echo -e "\n==== Installing NodeJS && NPM ====\n"
  sudo apt install -y nodejs  
  sudo npm install npm
fi

# Install local tunnel
if ( which /usr/bin/lt > /dev/null; )
then 
  echo -e "\n==== LT installed ====\n"
else 
  echo -e "\n==== Installing LT ====\n"
  sudo npm install -g localtunnel
fi

# Start the local tunnel on port 3000 and capture the output in a file
lt --port 3000 --print-requests > lt_output.txt 2>&1 &

# Wait for the local tunnel to start and capture the output
sleep 10
output=$(grep -E -o 'https://[[:alnum:]-]+\.loca\.lt' lt_output.txt)

# Check if the URL was found
if [[ $output ]]
then
  echo -e "\n==== LT_URL found $output updating variable in .env ====\n"
  # sed -i "s|^LT_URL=.*$|LT_URL=$output|" .env
  # sed -i "/^LT_URL=/s|=.*$|=$output|" .env
  # sed -i "s/^LT_URL=https:\/\/[[:alnum:]-]+\.loca\.lt\..*$/LT_URL=$output/" .env
  sed -i "s|^LT_URL=https://[[:alnum:]-]+\.loca\.lt\..*$|LT_URL=$output|" .env
  echo -e "\n==== LT_URL variable has been updated in the .env file ====\n"
else
  echo -e "\n==== LT_URL not found ====\n"
fi

# Install NPM dependencies
if [ -d node_modules ] 
then
  echo -e "\n==== Node_modules installed ====\n"
else 
  echo -e "\n==== Installing node_modules ====\n"
  npm install
fi

# Run NPM build
if [ -d build ] 
then
  echo -e "\n==== NPM build complete ====\n"
else 
  echo -e "\n==== Running NPM build ====\n"
  npm run build 
fi


<<notForDocker
# Copy service file and reload daemon
if [ -f /lib/systemd/system/crownapp.service ] 
then
  echo -e "\n==== Service file present ====\n"
else 
  echo -e "\n==== Copying crownapp.service ====\n"
  sudo cp crownapp.service /lib/systemd/system/ && sudo systemctl daemon-reload
fi


# Restart the crownapp service
if ( systemctl is-active crownapp.service ) 
then
  echo -e "\n==== Crownapp running ====\n"
else 
  echo -e "\n==== Starting crownapp ====\n"
  sudo systemctl restart crownapp.service
fi
notForDocker

echo -e "\n==== Install complete ====\n"

echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "
