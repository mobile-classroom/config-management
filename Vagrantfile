# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  # TODO: Make ip configurable
  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "shell", path: 'setup.sh'
end
