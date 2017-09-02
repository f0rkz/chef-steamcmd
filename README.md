# chef-steamcmd Cookbook

[![Build Status](https://travis-ci.org/f0rkz/chef-steamcmd.svg?branch=master)](https://travis-ci.org/f0rkz/chef-steamcmd) [![Cookbook Version](https://img.shields.io/cookbook/v/chef-steamcmd.svg)](https://supermarket.chef.io/cookbooks/chef-steamcmd)

Cookbook for managing Steamcmd based dedicated servers.

# Usage

Include `depends 'chef-steamcmd'` in your `metadata.rb`

# Resources

## steamcmd_cli

Steamcmd LWRP used to install steamcmd to a directory. On its own, this does not
do much except install steamcmd. This resource is useful if you just want steam
and nothing else installed.

### Actions

`:install`: (default) Installs steamcmd

### Properties

* `user`: User to install steamcmd. (Default: `root`)
* `group`: Group to install steamcmd. (Default: `root`)
* `download_dir`: Directory to download the steamcmd tarfile. (Default: `/tmp`)
* `url`: Steamcmd tarfile to install. (Default: `https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz`)
* `install_dir`: Directory to install steamcmd files. (Default: `/opt/steam`)

### Example Usage
```ruby
user 'steam' do
  comment 'Steam deployment user'
  system true
  home '/home/steam'
  manage_home true
  shell '/bin/bash'
end

steamcmd_cli 'install steamcmd' do
  user 'steam'
  group 'steam'
  install_dir '/home/steam/steamcmd'
  action :install
end
```

## steamcmd_app

Steamcmd LWRP used to install steam games to a directory.

### Actions

`:install`: (default) Installs steamcmd, installs gamefiles

### Properties

* `user`: `String` User to install steamcmd. (Default: `root`)
* `group`: `String` Group to install steamcmd. (Default: `root`)
* `steamcmd_dir`: `String` Steamcmd install directory. (Default: `/opt/steam`)
* `base_game_dir`: `String` Base dir to install game files. (Default: `/opt/steamgames`)
* `appid`: `String` The steam appid. See: https://steamdb.info/ (Required)
* `login`: `String` Optional steam login (Default: `anonymous`)
* `password`: `String` Optional steam password (Default `nil`)
* `check_files`: `[True, False]` Runs app_update with the `validate` option enabled. (Default: `false`)

### Example Usage
```ruby
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
```
# LICENSE AND AUTHOR

Author:: Nick Gray (f0rkz@f0rkznet.net)

Copyright 2017, f0rkznet.net

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
