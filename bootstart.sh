#!/bin/bash

yum install git -y
git clone https://github.com/Ruksov-Andrey/training/
cd /home/vagrant/training
git checkout task1-1
sed '3!d' /home/vagrant/training/README.txt