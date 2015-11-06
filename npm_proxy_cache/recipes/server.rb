#
# Cookbook Name:: npm_proxy_cache
# Recipe:: server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package ['npm', 'nodejs-legacy'] if node['npm_proxy_cache']['server']['install_nodejs']


execute 'npm_config' do
  command "npm config set prefix #{node['npm_proxy_cache']['install']['npm_package_dir']}"
end

execute "instll_npm_package" do
  command "npm install -g forever npm-proxy-cache"
end

execute 'npm_stop_proxy' do
  command "forever stop  /usr/bin/npm-proxy-cache"
  not_if { "forever list | grep npm-proxy-cache" }
end

execute 'npm_start_proxy' do
  command "#{node['npm_proxy_cache']['install']['npm_package_dir']}/bin/forever start  #{node['npm_proxy_cache']['install']['npm_package_dir']}/bin/npm-proxy-cache -e -h #{node['npm_proxy_cache']['start']['ip_address']} -p #{node['npm_proxy_cache']['start']['port']}"
end

file '/etc/init/npm_proxy_cache.conf' do
  content "start on started networking
  exec #{node['npm_proxy_cache']['install']['npm_package_dir']}/bin/forever start #{node['npm_proxy_cache']['install']['npm_package_dir']}/bin/npm-proxy-cache -e -h #{node['npm_proxy_cache']['start']['ip_address']} -p #{node['npm_proxy_cache']['start']['port']}"
end
