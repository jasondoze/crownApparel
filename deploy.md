<!-- https://dev.to/arc42/enable-ssh-access-to-multipass-vms-36p7 -->

# Deployment

## App dependencies 
node

## Deployment
how to deploy
<br>
copy the files
<br>
install node
<br>
cd to the app
<br>
run npm install
<br>
build the app
<br>
start the app from production mode: build
<br>
use the ssh key to scp the site up to the crown users directory
<br>
write a script that does all the deployment steps
<br>
install node
<br>
npm install
<br> 
npm start

<br>


# Start Here

# Crown User
Deploy crownuser to a server

<br>

# Create a crown user with ssh keys

## Enable ssh access to multipass vms

You want to ssh into the VM, because you cannot or don't want to use the standard shell command multipass shell <name-of-vm>.

The naive approach fails with permission denied:

```
ssh 192.168.205.7
The authenticity of host '192.168.205.7 (192.168.205.7)' can't be established.
ED25519 key fingerprint is SHA256:lWKUbxxxx.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.205.7' (ED25519) to the list of known hosts.
gernotstarke@192.168.205.7: Permission denied (publickey).

Permission denied, although there is a route to this virtual machine available...
```

<br>

## Create new ssh-key for your multipass VMs
---
Create a reusable launch configuration for multipass VMs with cloud-init
<br>
Launch new multipass VMs with this configuration
<br>
Find out IP-address of new multipass VM
<br>
ssh into the new VM with this IP-address

<br>

## Create ssh-key

---
On your host machine (the one with multipass installed), change to the directory from where you will be launching multipass vms. It can be your home directory, but any other will do.


`ssh-keygen -C crownapp -f multipass-ssh-key`

```
Your identification has been saved in multipass-ssh-key
Your public key has been saved in multipass-ssh-key.pub
```

<br>

vmuser can be any (dummy) username, it will later be used to log into the VM.
The parameter to -f is the filename for the generated key. You can choose a name of your liking, but there must not be an existing key with the same name in the same directory.
You will be asked to enter a passphrase, leave that empty! I know, it's not as secure as it should be, but multipass VMs are used for development and test only...

Empty passphrases are NOT suited for production environments.

<br>

## Create cloud-init configuration
---
Cloud-init is the standardized approach for cross-platform cloud and VM configuration of instance initialization.
Multipass can handle such configuration, we use it to pass the ssh key into the vm.

<br>

## In the directory where you generated the ssh-key, execute the following:

`touch cloud-init.yaml`

`nano cloud-init.yaml`


Put the following content into this file:
```
users:
  - default
  - name: vmuser
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    - <content of YOUR public key> 
```

<br>

The content with you public key starts with the letters ssh-rsa and ends with the username you supplied in step 1. Both have to be included!

<br>

Remember, it's yaml: Sensitive to spaces and dashes.
In case you generated an ed25519 type of key, it starts with ssh-ed25519. If you don't know what I'm talking about, ignore this last line.

<br>

## Launch multipass VM with ssh configuration
You will use a slightly different launch command for your VM, by adding the cloud-init parameter:

`multipass shell <name-of-vm>`

`multipass launch -n crownapp --cloud-init cloud-init.yaml`

Launched: testvm  

testvm is the name of your new vm, you can choose any name or even leave it blank. In the latter case, multipass will create a random name for you.

cloud-init.yaml is the name of the configuration file we created in step 2.

<br>

## Find IP address of new VM

`multipass info crownapp`
```
Name:           crownapp
State:          Running
IPv4:           192.168.64.9
Release:        Ubuntu 22.04.1 LTS
Image hash:     4d8d5b95082e (Ubuntu 22.04 LTS)
Load:           0.77 0.25 0.09
Disk usage:     1.4G out of 4.7G
Memory usage:   176.8M out of 969.6M
Mounts:         --
```

testvm is the name of the VM you were using in step 3 (launch VM).
The output of the info command contains the IPv4 address of this VM, you need that in the next step.

<br>

## ssh into new VM

`ssh crownapp@192.168.64.9 -i multipass-ssh-key -o StrictHostKeyChecking=no`

`sudo apt update`

```
Ign:1 http://packages.chef.io/repos/apt/stable jammy InRelease
Err:2 http://packages.chef.io/repos/apt/stable jammy Release          
  404  Not Found [IP: 199.232.10.110 80]
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease                
Hit:4 http://security.ubuntu.com/ubuntu jammy-security InRelease      
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease        
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
E: The repository 'http://packages.chef.io/repos/apt/stable jammy Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
crownapp@crownapp:~$ 
```

<br>

```
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-125-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Sep 20 19:53:34 CDT 2022

  System load:             0.4
  Usage of /:              29.4% of 4.67GB
  Memory usage:            20%
  Swap usage:              0%
  Processes:               117
  Users logged in:         0
  IPv4 address for enp0s2: 192.168.64.8
  IPv6 address for enp0s2: fd77:5f2:3f30:c26f:874:61ff:fe3b:4400


0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.
 ```

<br>

vmuser is the username for which you created the ssh key
Please replace the IP address by the one you found out in step 4.
And voilá - you made it.
The command itself should be obvious... you pass the name of the ssh-key with the -i command (short for identity). 

<br>

In addition, you turn strict host checking off.

You might see additional messages, depending on your host machine ssh configuration - but you should be logged in your multipass VM by now.

<br>

# After stopping the instance, purging, and repeating the above process:

```
jasondoze@jd crown-apparel % ssh vmuser@192.168.64.8 -i multipass-ssh-key -o StrictHostKeyChecking=no
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:L0dOsCXeNtkdfMeKIcoFz0X9RMv38z5RvaoPv1bba28.
Please contact your system administrator.
Add correct host key in /Users/jasondoze/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /Users/jasondoze/.ssh/known_hosts:18
Password authentication is disabled to avoid man-in-the-middle attacks.
Keyboard-interactive authentication is disabled to avoid man-in-the-middle attacks.
UpdateHostkeys is disabled because the host key is not trusted.
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-125-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Sep 21 12:42:39 CDT 2022

  System load:             0.24
  Usage of /:              29.4% of 4.67GB
  Memory usage:            20%
  Swap usage:              0%
  Processes:               117
  Users logged in:         0
  IPv4 address for enp0s2: 192.168.64.8
  IPv6 address for enp0s2: fd77:5f2:3f30:c26f:874:61ff:fe3b:4400


0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

$ 
```

<br>

---


```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
22 packages can be upgraded. Run 'apt list --upgradable' to see them.
```
<br>

# System reboot and follow tutorial process
---

Permission denied (publickey).

<br>

## Uninstall and reinstall multipass and follow tutorial
---

```
jasondoze@jd crown-apparel % ssh-keygen -C vmuser -f multipass-ssh-key
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in multipass-ssh-key
Your public key has been saved in multipass-ssh-key.pub
The key fingerprint is:
SHA256:SeuARR84fp8R66E5O7dFTDVkIrF6WKw4ggoJX5TfzM4 vmuser
The key's randomart image is:
+---[RSA 3072]----+
|    ..... o...=  |
|   ...o. o.o + . |
|.   .o.=o +o.    |
|.o o ooo=B+o     |
|o o o ++S=.+o    |
|..   . +E.+.     |
|.       .o  .    |
|        o ..     |
|         o..     |
+----[SHA256]-----+
jasondoze@jd crown-apparel % touch cloud-init.yaml
jasondoze@jd crown-apparel % multipass launch -n testvm --cloud-init cloud-init.yaml
Launched: testvm                                                                
jasondoze@jd crown-apparel % multipass info testvm
Name:           testvm
State:          Running
IPv4:           192.168.64.8
Release:        Ubuntu 22.04.1 LTS
Image hash:     1d24e397489d (Ubuntu 22.04 LTS)
Load:           0.80 0.22 0.07
Disk usage:     1.4G out of 4.7G
Memory usage:   167.4M out of 969.6M
Mounts:         --
jasondoze@jd crown-apparel % ssh vmuser@192.168.64.8 -i multipass-ssh-key -o StrictHostKeyChecking=no

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:Z5TYNGhveuen9V4tWIErRs1zApSsRjgKr8P36+3l5/4.
Please contact your system administrator.
Add correct host key in /Users/jasondoze/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /Users/jasondoze/.ssh/known_hosts:6
Password authentication is disabled to avoid man-in-the-middle attacks.
Keyboard-interactive authentication is disabled to avoid man-in-the-middle attacks.
UpdateHostkeys is disabled because the host key is not trusted.
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Nov  6 20:44:08 UTC 2022

  System load:             0.857421875
  Usage of /:              29.9% of 4.67GB
  Memory usage:            19%
  Swap usage:              0%
  Processes:               109
  Users logged in:         0
  IPv4 address for enp0s2: 192.168.64.8
  IPv6 address for enp0s2: fd77:5f2:3f30:c26f:874:61ff:fe3b:4400


0 updates can be applied immediately.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

$ ls
$ cd /
$ ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  lost+found  media  mnt  opt  proc  root  run  sbin  snap  srv  sys  tmp  usr  var
```

<br>

### Offending ED25519 key in /Users/jasondoze/.ssh/known_hosts:6
---
Removed this key

ssh back into vm

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:Z5TYNGhveuen9V4tWIErRs1zApSsRjgKr8P36+3l5/4.
Please contact your system administrator.
Add correct host key in /Users/jasondoze/.ssh/known_hosts to get rid of this message.

Offending ED25519 key in /Users/jasondoze/.ssh/known_hosts:5

Password authentication is disabled to avoid man-in-the-middle attacks.
Keyboard-interactive authentication is disabled to avoid man-in-the-middle attacks.
UpdateHostkeys is disabled because the host key is not trusted.
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Nov  6 15:04:57 CST 2022

  System load:             0.11865234375
  Usage of /:              30.5% of 4.67GB
  Memory usage:            17%
  Swap usage:              0%
  Processes:               105
  Users logged in:         0
  IPv4 address for enp0s2: 192.168.64.8
  IPv6 address for enp0s2: fd77:5f2:3f30:c26f:874:61ff:fe3b:4400

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

0 updates can be applied immediately.


Last login: Sun Nov  6 14:56:36 2022 from 192.168.64.1
```

<br>

## Tried with strict checking on
---

`ssh -i ./multipass-ssh-key testvm@192.168.64.8`

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:Z5TYNGhveuen9V4tWIErRs1zApSsRjgKr8P36+3l5/4.
Please contact your system administrator.
Add correct host key in /Users/jasondoze/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /Users/jasondoze/.ssh/known_hosts:5
Host key for 192.168.64.8 has changed and you have requested strict checking.
Host key verification failed.
```

1. Use && to make one command to get vm to logged in, and one command to delete, purge, and list vm

`multipass delete crownapp && multipass purge && multipass list`

<br>

2. Create scp command to copy code

`scp -r /Users/jasondoze/reactFullStack/crown-apparel/build crownapp@192.168.64.9:/home/crownapp`


# 4cpu 2gig memory on multipass docs