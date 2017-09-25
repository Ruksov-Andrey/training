#
# Cookbook:: test1
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.



docker_service 'default' do
  action [:create, :start]
end

docker_service 'default' do
  insecure_registry '{"insecure-registries" : ["172.20.20.12:5000"]}'
end

docker_service 'default' do
  action [:restart]
end