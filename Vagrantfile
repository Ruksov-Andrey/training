# -*- mode: ruby -*-
# vi: set ft=ruby :

#Run with the command VAGRANT UP --PROVISION



Vagrant.configure(2) do |config|
	config.vm.box = "bertvv/centos72"
	config.vm.boot_timeout = 500000
	config.vm.provider "virtualbox" do |vb|
	vb.gui = true
	end

  config.vm.define "apache" do |apache|
	apache.vm.hostname = "apache"
	apache.vm.network "private_network", ip: "172.20.20.12"
	apache.vm.network "forwarded_port", guest: 22, host: 2230
	apache.vm.network "forwarded_port", guest: 80, host: 9090
	apache.vm.provision :shell, path: "apache.sh"
	end

  config.vm.define "tomcat1" do |tomcat1|
	tomcat1.vm.hostname = "tomcat1"
	tomcat1.vm.network "forwarded_port", guest: 22, host: 2210
	tomcat1.vm.network "private_network", ip: "172.20.20.10"  
	tomcat1.vm.provision :shell, path: "tomcat.sh"
	tomcat1.vm.provision :shell, path: "index1.sh"
	end
	
  config.vm.define "tomcat2" do |tomcat2|
	tomcat2.vm.hostname = "tomcat2"
	tomcat2.vm.network "private_network", ip: "172.20.20.11"
	tomcat2.vm.network "forwarded_port", guest: 22, host: 2220
	tomcat2.vm.provision :shell, path: "tomcat.sh"
	tomcat2.vm.provision :shell, path: "index2.sh"
	end

	config.vm.provision :shell, path: "firewall.sh"
	
end
