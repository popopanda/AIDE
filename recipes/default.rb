#
# Cookbook Name:: aide
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package node['aide']['package']['install'] do
  action :install
end

cookbook_file "#{node['aide']['cron']['directory']}/cron_aide.sh" do
  source node['aide']['cron']['src']
  mode node['aide']['cron']['chmod']
end

cron_d "daily_aide_check" do
  minute 0
  hour 5
  command "#{node['aide']['cron']['directory']}/cron_aide.sh"
end

template "#{node['aide']['config']['directory']}/aide.conf" do
  source node['aide']['config']['src']
end

template "#{node['aide']['wrapper']['directory']}/aide" do
  source node['aide']['wrapper']['src']
  variables ({
    :email => node['aide']['email']
  })
  notifies :run, 'execute[initialize_aide]', :immediately
end

execute "initialize_aide" do
  command "aideinit"
  action :nothing
  notifies :run, 'ruby_block[rename_aide_db]', :immediately
end

ruby_block "rename_aide_db" do
  block do
    ::File.rename(node['aide']['db']['new'], node['aide']['db']['using'])
  end
  action :nothing
  notifies :run, 'ruby_block[aide_check]', :delayed
end

ruby_block "aide_check" do
  block do
    system('sudo aide.wrapper --check')
  end
  action :nothing
end
