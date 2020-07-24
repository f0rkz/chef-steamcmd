#
# Cookbook:: chef-steamcmd
# Resource:: cli
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
resource_name :steamcmd_cli
provides :steamcmd_cli

property :steamcmdcli_user,                  String, default: 'root'
property :steamcmdcli_group,                 String, default: 'root'
property :steamcmdcli_download_dir,          String, default: '/tmp'
property :steamcmdcli_url,                   String, default: 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'
property :steamcmdcli_install_dir,           String, default: '/opt/steam'

default_action :install

action :install do
  package 'lib32gcc1'
  package 'ca-certificates' do
    options('--reinstall')
  end
  s = new_resource

  directory s.steamcmdcli_install_dir do
    owner s.steamcmdcli_user
    group s.steamcmdcli_group
    mode '0755'
    recursive true
    action :create
  end

  tar_extract s.steamcmdcli_url do
    download_dir s.steamcmdcli_download_dir
    target_dir s.steamcmdcli_install_dir
    user s.steamcmdcli_user
    group s.steamcmdcli_group
  end

  execute 'run steamcmd' do
    user s.steamcmdcli_user
    group s.steamcmdcli_group
    command <<-EOL
    #{s.steamcmdcli_install_dir}/steamcmd.sh +quit
    EOL
    action :run
  end
end
