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

# cd into the crown app directory
if [[ ${PWD} = */crown-apparel/* ]]
then 
  echo -e "\n==== Already on start path ===="
else
  echo -e "\n==== Navigate to start path ===="
  cd ~/crown-apparel && pwd
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







<<nmap 
jasondoze@jd ~ % nmap 192.168.1.249
Starting Nmap 7.93 ( https://nmap.org ) at 2022-11-21 19:09 CST
Nmap scan report for jd.attlocal.net (192.168.1.249)
Host is up (0.000096s latency).
Not shown: 997 closed tcp ports (conn-refused)
PORT     STATE SERVICE
53/tcp   open  domain
88/tcp   open  kerberos-sec
5900/tcp open  vnc

jasondoze@jd ~ % nmap 192.168.64.9     
Starting Nmap 7.93 ( https://nmap.org ) at 2022-11-21 19:12 CST
Nmap scan report for 192.168.64.9
Host is up (0.10s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT     STATE SERVICE
22/tcp   open  ssh
3000/tcp open  ppp

jasondoze@jd ~ % nmap -sV 192.168.1.249
Starting Nmap 7.93 ( https://nmap.org ) at 2022-11-21 19:37 CST
Nmap scan report for jd.attlocal.net (192.168.1.249)
Host is up (0.00012s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT     STATE SERVICE VERSION
5900/tcp open  vnc     Apple remote desktop vnc
Service Info: OS: Mac OS X; CPE: cpe:/o:apple:mac_os_x

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.73 seconds
jasondoze@jd ~ % nmap -A 192.168.1.249
Starting Nmap 7.93 ( https://nmap.org ) at 2022-11-21 19:38 CST
Nmap scan report for jd.attlocal.net (192.168.1.249)
Host is up (0.00013s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT     STATE SERVICE VERSION
5900/tcp open  vnc     Apple remote desktop vnc
| vnc-info: 
|   Protocol version: 3.889
|   Security types: 
|     Apple Remote Desktop (30)
|     Unknown security type (33)
|     Unknown security type (36)
|     Unknown security type (31)
|     Unknown security type (32)
|_    Mac OS X security type (35)
Service Info: OS: Mac OS X; CPE: cpe:/o:apple:mac_os_x

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.72 seconds

ip a | awk -F"[/ ]+" '/inet / {print $ 3}' | tail -1 

lsof -i -P -n | grep LISTEN
// node    2561 jason   20u  IPv4  26755      0t0  TCP *:3000 (LISTEN)

ss -tulw

//
Netid         State          Recv-Q         Send-Q                                      Local Address:Port                          Peer Address:Port         Process         
icmp6         UNCONN         0              0                                                *%enp0s2:ipv6-icmp                                *:*                            
udp           UNCONN         0              0                                           127.0.0.53%lo:domain                             0.0.0.0:*                            
udp           UNCONN         0              0                                     192.168.64.9%enp0s2:bootpc                             0.0.0.0:*                            
udp           UNCONN         0              0                      [fe80::30fe:43ff:fe4b:9f71]%enp0s2:dhcpv6-client                         [::]:*                            
tcp           LISTEN         0              4096                                        127.0.0.53%lo:domain                             0.0.0.0:*                            
tcp           LISTEN         0              128                                               0.0.0.0:ssh                                0.0.0.0:*                            
tcp           LISTEN         0              511                                               0.0.0.0:3000                               0.0.0.0:*                            
tcp           LISTEN         0              128                                                  [::]:ssh                                   [::]:*                            

nmap