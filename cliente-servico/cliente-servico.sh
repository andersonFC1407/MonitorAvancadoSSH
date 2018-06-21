#!/bin/bash

#Executar como root

sudo apt install openssh-server

sudo useradd -m -s /bin/bash ubuntu

sudo addgroup ubuntu sudo

sudo mkdir /home/ubuntu/.ssh

sudo cp cliente.pub /home/ubuntu/.ssh/authorized_keys

sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh/

sudo visudo #Inserir ubuntu ALL=NOPASSWD:ALL e crtl+w
