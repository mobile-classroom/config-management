#!/bin/bash

# Setup the chef repository
# TODO: Use local repository
curl -s https://packagecloud.io/install/repositories/chef/stable/script.rpm.sh | sudo bash

# Install some packages
yum -y install chef-server-core

# Install the chef management console
chef-server-ctl install chef-manage
chef-manage-ctl reconfigure
chef-server-ctl reconfigure
