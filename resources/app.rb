#
# Cookbook:: steamcmd
# Resource:: app
#
# Author:: Nick Gray (f0rkz@f0rkznet.net)
#
# Copyright:: 2017 f0rkznet.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
property :user,                  String, default: 'root'
property :group,                 String, default: 'root'
property :steamcmd_dir,          String, default: '/opt/steam'
property :base_game_dir,         String, default: '/opt/steamgames'
property :appid,                 String
property :login,                 String, default: 'anonymous'
property :password,              String

default_action :install

action :install do
  app = new_resource

  Chef::Application.fatal!('No appid defined!') unless app.appid

  directory app.base_game_dir do
    owner app.user
    group app.group
    mode '0755'
    recursive true
    action :create
  end

  steamcmd_cli 'install steamcmd' do
    user app.user
    group app.group
    install_dir app.steamcmd_dir
    action :install
  end

  if app.password
    execute 'Install steamapp with password' do
      user app.user
      group app.group
      command <<-EOL
      #{app.steamcmd_dir}/steamcmd.sh +login #{app.login} +password #{app.password} +force_install_dir #{app.base_game_dir}/#{app.appid} +app_update #{app.appid} +quit
      EOL
      action :run
      live_stream true
    end
  else
    execute 'Install steamapp without password' do
      user app.user
      group app.group
      command <<-EOL
      #{app.steamcmd_dir}/steamcmd.sh +login #{app.login} +force_install_dir #{app.base_game_dir}/#{app.appid} +app_update #{app.appid} +quit
      EOL
      action :run
      live_stream true
    end
  end
end
