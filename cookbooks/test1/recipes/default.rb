#
# Cookbook:: test1
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


docker_service 'default' do
  action [:create, :start]
end

bash 'add_docker_option' do
  code <<-EOH
    echo '{"insecure-registries" : ["172.20.20.12:5000"]}' > /etc/docker/daemon.json
    EOH
end

