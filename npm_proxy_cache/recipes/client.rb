#
# Cookbook Name:: npm_proxy_cache
# Recipe:: client
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'nodejs' if node['npm_proxy_cache']['client']['install_nodejs']

execute 'set npm_proxy' do
  command "npm config set proxy  http://#{node['npm_proxy_cache']['start']['ip_address']}:#{node['npm_proxy_cache']['start']['port']}
  npm config set https-proxy  http://#{node['npm_proxy_cache']['start']['ip_address']}:#{node['npm_proxy_cache']['start']['port']}
  npm config set strict-ssl false"
end

directory '/usr/test'

cookbook_file 'usr/test/package.json' do
  source 'client/package.json'
end
