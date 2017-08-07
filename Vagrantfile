# -*- mode: ruby -*-
# vi: set ft=ruby :

#Run with the command VAGRANT UP --PROVISION
#My first vagrantfile


Vagrant.configure(2) do |config|

  config.vm.box = "bertvv/centos72"
  config.vm.boot_timeout = 5000000
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
   
	config.vm.define "server1" do |server1|
      server1.vm.hostname = "server1"
      server1.vm.network "private_network", ip: "172.20.20.10"
	  server1.vm.provision :shell, :inline => "
	  echo '172.20.20.11 server2' >> /etc/hosts
	  sudo yum install git -y
      git clone https://github.com/Ruksov-Andrey/training/
	  cd /home/vagrant/training
	  git checkout task1
	  sed '3!d' /home/vagrant/training/README.txt"

	  
	end
	  
    config.vm.define "server2" do |server2|
      server2.vm.hostname = "server2"
      server2.vm.network "private_network", ip: "172.20.20.11"
	  server2.vm.provision :shell, :inline => "echo '172.20.20.10 server1' >> /etc/hosts"
    end   
	
	
	
end






