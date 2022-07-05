#!/bin/bash
apt update && apt install -y openssh-server;
apt install -y curl vim docker.io docker-compose make;
CHECHK_HOSTS=$(grep 42cadet.fr /etc/hosts);
if [ $? -eq 1 ]; then
	echo "127.0.0.1 mypark.42cadet.fr" >> /etc/hosts;
fi;
