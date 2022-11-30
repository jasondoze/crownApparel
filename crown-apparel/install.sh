#!bin/bash
echo -e "==== Beginning install ====\n"

if ( apt-cache show nodejs ) 
then
  echo -e "\n==== Node setup already installed ===="
else 
  echo -e "\n==== Checking if Nodejs setup is installed ===="
  curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
fi

# make sure node & npm is installed
if ( which node ) 
then
  echo -e "\n==== Node already installed ===="
else 
  echo -e "\n==== Installing Nodejs && npm ===="
  sudo apt install -y nodejs
fi

# install npm and its dependencies
if [ -d node_modules ] 
then
  echo -e "\n==== Node_modules already installed ===="
else 
  echo -e "\n==== Installing node_modules ====\n"
  npm install
fi

# run npm build
if [ -d build ] 
then
  echo -e "\n==== Npm run build complete ===="
else 
  echo -e "\n==== Running npm build ===="
  npm run build
fi

echo -e "\n==== Install complete ====\n"

echo "                                                                                                         "
echo "  _________                                       _____                                           .__    "
echo "  \_   ___ \ _______   ____  __  _  __  ____     /  _  \  ______  ______  _____   _______   ____  |  |   "
echo "  /    \  \/ \_  __ \ /  _ \ \ \/ \/ / /    \   /  /_\  \ \____ \ \____ \ \__  \  \_  __ \_/ __ \ |  |   "
echo "  \     \____ |  | \/(  <_> ) \     / |   |  \ /    |    \|  |_> >|  |_> > / __ \_ |  | \/\  ___/ |  |__ "
echo "   \______  / |__|    \____/   \/\_/  |___|  / \____|__  /|   __/ |   __/ (____  / |__|    \___  >|____/ "
echo "          \/                               \/          \/ |__|    |__|         \/              \/        "

# run the application
echo -e "\n==== Run crownapp ===="
npm start 



# sudo curl http://192.168.64.9:3000

# show that the app is running through the ip address

# hostname -i

# and curl ip

# write a system d service that runs the app and enables it, how to write systemd for node

# make sure node setup is installed






