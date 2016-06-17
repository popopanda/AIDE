#
# Cookbook Name:: aide
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package "aide" do
  action :install
end

template "/etc/aide/aide.conf" do
  source "aide.conf.erb"
end

template "/etc/default/aide" do
  source "aide.erb"
  notifies :run, 'execute[initialize_aide]', :immediately
end

execute "initialize_aide" do
  command "aideinit"
  action :nothing
  notifies :run, 'ruby_block[rename_aide_db]', :immediately
end

ruby_block "rename_aide_db" do
  block do
    ::File.rename("/var/lib/aide/aide.db.new", "/var/lib/aide/aide.db")
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

cookbook_file "/usr/local/etc/cron_aide.sh" do
  source "cron_aide.sh"
  mode "0755"
end

cron_d "daily_aide_check" do
  minute 0
  hour 5
  command "/usr/local/etc/cron_aide.sh"
end
