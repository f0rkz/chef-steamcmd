#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, f0rkznet.net

user 'steam' do
  comment 'Steam deployment user'
  system true
  home '/home/steam'
  shell '/bin/bash'
end

steamcmd_app 'install terraria dedi' do
  steamcmd_appid '222840'
  steamcmd_user 'steam'
  steamcmd_group 'steam'
  steamcmd_validate true
  action :install
end
