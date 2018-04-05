#!/bin/bash
#Script must be run using sudo to work
if [ "$EUID" -ne 0 ]
  then echo "Please run with su permissions. e.g. sudo ./setup.sh"
  exit
fi
apt-get update
apt-get install -y samba curl git
# Add your user account 
adduser al --gecos "" --disabled-password --force-badname
echo "al:password" | chpasswd
adduser al sudo
sudostring="\nal\tALL=(ALL) NOPASSWD: ALL"
echo -e $sudostring >> /etc/sudoers
#Install stuff
cp /etc/samba/smb.conf /etc/samba/smb.conf.org
cp ./smb.conf /etc/samba/smb.conf
service smbd restart
./dockeru.sh
