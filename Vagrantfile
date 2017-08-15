# -*- mode: ruby -*-
# vi: set ft=ruby :

# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.


BOX_IMAGE = "bertvv/centos72"
TOMCAT_COUNT = 2

Vagrant.configure("2") do |config|
  config.vm.define "apache" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "apache"
	subconfig.vm.network :private_network, ip: "10.0.0.10"
	subconfig.vm.network "forwarded_port", guest: 22, host: 2230
	subconfig.vm.network "forwarded_port", guest: 80, host: 9090
    subconfig.vm.provision :shell, path: "apache.sh"
  end
  
  (1..TOMCAT_COUNT).each do |i|
    config.vm.define "tomacat#{i}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "tomcat#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.#{i + 10}"
    end
  end

  # Stop firewall on all machines  
  config.vm.provision :shell, path: "firewall.sh"

end

