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

property :user,                  String, default: 'root'
property :group,                 String, default: 'root'
property :download_dir,          String, default: '/tmp'
property :url,                   String, default: 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'
property :install_dir,           String, default: '/opt/steam'

default_action :install

action :install do
  package 'lib32gcc1'
  s = new_resource

  directory s.install_dir do
    owner s.user
    group s.group
    mode '0755'
    recursive true
    action :create
  end

  tar_extract s.url do
    download_dir s.download_dir
    target_dir s.install_dir
    user s.user
    group s.group
  end

  execute 'run steamcmd' do
    user s.user
    group s.group
    command <<-EOL
    #{s.install_dir}/steamcmd.sh +quit
    EOL
    action :run
  end
end
