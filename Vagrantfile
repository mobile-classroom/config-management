# -*- mode: ruby -*-
# vi: set ft=ruby :

module Classroom
  module ConfigManagement
    attr_accessor :url
    module_function :url, :url=
    module Admin
      attr_accessor :username, :password, :firstname, :lastname, :email
      module_function \
        :username, :username=, \
        :password, :password=, \
        :firstname, :firstname=, \
        :lastname, :lastname=, \
        :email, :email=
    end
    module Organization
      attr_accessor :shortName, :longName
      module_function \
        :shortName, :shortName=, \
        :longName, :longName=
    end
  end
end

if File.exists?('../Vagrantfile.global')
  load '../Vagrantfile.global'
end

$provisionUser = <<SCRIPT
chef-server-ctl user-create \
#{Classroom::ConfigManagement::Admin::username} \
#{Classroom::ConfigManagement::Admin::firstname} \
#{Classroom::ConfigManagement::Admin::lastname} \
#{Classroom::ConfigManagement::Admin::email} \
#{Classroom::ConfigManagement::Admin::password} \
--filename #{Classroom::ConfigManagement::Admin::username}.pem
SCRIPT

$provisionOrganization = <<SCRIPT
chef-server-ctl org-create \
#{Classroom::ConfigManagement::Organization::shortName} \
"#{Classroom::ConfigManagement::Organization::longName}" \
--association_user #{Classroom::ConfigManagement::Admin::username}
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  # TODO: Make ip configurable
  config.vm.network "private_network", type: "dhcp"

  config.vm.network "forwarded_port", guest: 443, host: 50443

  config.vm.provision "shell", path: 'setup.sh'
  config.vm.provision "shell", inline: $provisionUser
  config.vm.provision "shell", inline: $provisionOrganization

end
