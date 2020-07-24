#
# Cookbook:: chef-steamcmd
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
resource_name :steamcmd_app
provides :steamcmd_app

property :steamcmd_user,                  String, default: 'root'
property :steamcmd_group,                 String, default: 'root'
property :steamcmd_dir,                   String, default: '/opt/steam'
property :steamcmd_base_game_dir,         String, default: '/opt/steamgames'
property :steamcmd_appid,                 String, required: true
property :steamcmd_login,                 String, default: 'anonymous'
property :steamcmd_password,              String
# Unfortunately the property name "validate" is reserved or something...
# This is actually the +validate option in steam.
property :steamcmd_validate,              [true, false], default: false

default_action :install

action :install do
  app = new_resource

  launch_password = "+password #{app.steamcmd_password}" if app.steamcmd_password
  launch_validate = 'validate' if app.steamcmd_validate

  directory app.steamcmd_base_game_dir do
    owner app.steamcmd_user
    group app.steamcmd_group
    mode '0755'
    recursive true
    action :create
  end

  steamcmd_cli 'install steamcmd' do
    steamcmdcli_user app.steamcmd_user
    steamcmdcli_group app.steamcmd_group
    steamcmdcli_install_dir app.steamcmd_dir
    action :install
  end

  execute 'Install steamapp' do
    user app.steamcmd_user
    group app.steamcmd_group
    command <<-EOL
    #{app.steamcmd_dir}/steamcmd.sh +login #{app.steamcmd_login} #{launch_password} +force_install_dir #{app.steamcmd_base_game_dir}/#{app.steamcmd_appid} +app_update #{app.steamcmd_appid} #{launch_validate} +quit
    EOL
    action :run
    live_stream true
  end
end
