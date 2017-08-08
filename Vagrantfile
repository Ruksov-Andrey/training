# -*- mode: ruby -*-
# vi: set ft=ruby :

#Run with the command VAGRANT UP --PROVISION
#My second vagrantfile


servers=[
  {
    :hostname => "server1",
    :ip => "172.20.20.10"        
  },
  {
    :hostname => "server2",
    :ip => "172.20.20.11"       
  }
]

INDEX_OF_SERVER_USE_GIT = 1

Vagrant.configure(2) do |config|

  config.vm.box = "bertvv/centos72"
  config.vm.boot_timeout = 5000000
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end    
  
  servers.each_with_index do |machine, index|
    config.vm.define machine[:hostname] do |cfg|
      cfg.vm.hostname = machine[:hostname]
      cfg.vm.network "private_network", ip: machine[:ip]	  	 
	  
	  servers.each do |server|	  
	    cfg.vm.provision :shell, :inline => "echo '#{server[:ip]} #{server[:hostname]}' >> /etc/hosts"
	  end
	  
	  if index == INDEX_OF_SERVER_USE_GIT
	    cfg.vm.provision :shell, path: "bootstart.sh"	 
	  end
	  	  
    end
  end

end