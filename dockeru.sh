#!/bin/bash
#Install docker
machineVer="0.14.0"
composeVer="1.20.1"
sudo apt-get update
sudo apt-get install -y curl
curl -fsSL get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo rm ./get-docker.sh
#Install docker machine
curl -L "https://github.com/docker/machine/releases/download/v$machineVer/docker-machine-`uname -s`-`uname -m`" >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
#Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/$composeVer/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker container run -d --tty --name ubuntu ubuntu
sudo docker container rm -f ubuntu
run="alias ubuntu='docker container run -d --tty --name ubuntu ubuntu'"
attach="alias attach_ubuntu='docker container exec -it ubuntu /bin/bash'"
remove="alias rm_ubuntu='docker container rm -f ubuntu'"
if [ -d /home/al ]; then
	echo $run >> /home/al/.bashrc
	echo $attach >> /home/al/.bashrc
	echo $remove >> /home/al/.bashrc
	sudo usermod -aG docker al
else
	echo $run >> ~/.bashrc
	echo $attach >> ~/.bashrc
	echo $remove >> ~/.bashrc
	sudo usermod -aG docker $(whoami)
fi
