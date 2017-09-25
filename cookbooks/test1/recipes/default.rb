#
# Cookbook:: test1
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


directory '/etc/docker' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/etc/docker/daemon.json' do
  content '{"insecure-registries" : ["172.20.20.12:5000"]}'
  mode '0755'
  owner 'root'
  group 'root'
end




docker_service 'default' do
  action [:create, :start]
end



