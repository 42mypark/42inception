#!/bin/bash
apt update && apt install -y openssh-server;
apt install -y curl vim docker.io docker-compose make;
echo "127.0.0.1 mypark.42cadet.kr" >> /etc/hosts;
