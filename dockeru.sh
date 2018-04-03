#!/bin/bash
#Install docker
machineVer="0.14.0"
composeVer="1.20.1"
sudo apt-get update
sudo apt-get install -y curl
curl -fsSL get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo usermod -aG docker vagrant
#Install docker machine
curl -L "https://github.com/docker/machine/releases/download/v$machineVer/docker-machine-`uname -s`-`uname -m`" >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
#Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/$composeVer/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker container run -d --tty --name ubuntu ubuntu
sudo docker container rm -f ubuntu
echo "alias ubuntu='docker container run -d --tty --name ubuntu ubuntu'" >> ~/.bashrc
echo "alias attach_ubuntu='docker container exec -it ubuntu /bin/bash'" >> ~/.bashrc
echo "alias rm_ubuntu='docker container rm -f ubuntu'" >> ~/.bashrc