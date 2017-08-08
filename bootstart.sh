#!/bin/bash


echo '172.20.20.11 server2' >> /etc/hosts
      yum install git -y
      git clone https://github.com/Ruksov-Andrey/training/
      cd /home/vagrant/training
      git checkout task1
      sed '3!d' /home/vagrant/training/README.txt