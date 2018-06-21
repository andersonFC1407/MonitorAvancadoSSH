#!/bin/bash

sudo apt install openssh-server

sudo useradd -m -s /bin/bash ubuntu

sudo addgroup ubuntu sudo

sudo mkdir /home/ubuntu/.ssh

cp clientes.pub /home/ubuntu/.ssh/authorized_keys

sudo chwon -R ubuntu:ubuntu /home/ubuntu/.ssh/

sudo chmod 660 /etc/sudoers

echo "ubuntu ALL=NOPASSWD:ALL" >> /etc/sudoers
