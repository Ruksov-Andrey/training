#!/bin/bash

	echo "Setup APACHE"
	yum install httpd -y
	systemctl enable httpd
	
	cp /vagrant/mod_jk.so /etc/httpd/modules/
	
	echo "LoadModule jk_module modules/mod_jk.so" >> /etc/httpd/conf/httpd.conf
	echo "JkWorkersFile conf/workers.properties" >> /etc/httpd/conf/httpd.conf
	touch /etc/httpd/conf/workers.properties 
	
	echo "worker.list=lb"
	echo "worker.lb.type=lb"
	
	
	
	
	
	echo "JkShmFile /tmp/shm" >> /etc/httpd/conf/httpd.conf
	echo "JkLogFile logs/mod_jk.log" >> /etc/httpd/conf/httpd.conf
	echo "JkLogLevel info" >> /etc/httpd/conf/httpd.conf
	echo "JkMount /unit2* lb" >> /etc/httpd/conf/httpd.conf

	echo "Satrt APACHE"
	systemctl start httpd

	
	
	#cp /vagrant/workers.properties /etc/httpd/conf/
	#