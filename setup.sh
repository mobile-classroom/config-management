#!/bin/bash

# Setup the chef repository
curl -s https://packagecloud.io/install/repositories/chef/stable/script.rpm.sh | sudo bash

# Install some packages
yum -y install chef-server-core

# Install the chef management console
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure

# TODO: Create initial user