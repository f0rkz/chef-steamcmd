name 'steamcmd'
maintainer 'Nick Gray'
maintainer_email 'f0rkz@f0rkznet.net'
license 'Apache-2.0'
description 'Installs/Configures steamcmd'
long_description 'Installs/Configures steamcmd'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/f0rkz/chef-steamcmd/issues'
source_url 'https://github.com/f0rkz/chef-steamcmd'
depends 'tar'

%w(ubuntu debian).each do |os|
  supports os
end
