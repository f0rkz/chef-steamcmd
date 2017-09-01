#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, f0rkznet.net

user 'steam' do
  comment 'Steam deployment user'
  system true
  home '/home/steam'
  manage_home true
  shell '/bin/bash'
end

steamcmd_app 'install hldm' do
  appid '90'
  user 'steam'
  group 'steam'
  action :install
end
