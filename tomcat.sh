#!/bin/bash

echo "_______________________________________________________________УСТАНОВКА TOMCAT"
yum install java-1.8.0-openjdk -y
yum install tomcat tomcat-webapps tomcat-admin-webapps -y
systemctl enable tomcat
systemctl start tomcat 

systemctl stop firewalld 
