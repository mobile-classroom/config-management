# -*- mode: ruby -*-
# vi: set ft=ruby :

module Classroom
  module ConfigManagement
    attr_accessor :url, :ports
    module_function \
     :url, :url=, \
     :ports, :ports=
     @ports = {
       443 => 50443
     }
     @url = 'https://localhost:50443'

    module Admin
      attr_accessor :username, :password, :firstname, :lastname, :email
      module_function \
        :username, :username=, \
        :password, :password=, \
        :firstname, :firstname=, \
        :lastname, :lastname=, \
        :email, :email=
        @username = 'Admin'
        @password = 'm0b1le-cl4ssr00m'
        @firstname = 'Classroom'
        @lastname = 'Admin'
        @email = 'admin@example.org'
    end

    module Organization
      attr_accessor :shortName, :longName
      module_function \
        :shortName, :shortName=, \
        :longName, :longName=
        @shortName = 'mocl'
        @longName = 'Mobile Classroom'
    end

    module Box
      attr_accessor :ipAddress, :syncDirHost, :syncDirGuest
      module_function \
        :ipAddress, :ipAddress=,
        :syncDirHost, :syncDirHost=,
        :syncDirGuest, :syncDirGuest=
        @syncDirHost = ENV['HOME']
        @syncDirGuest = ENV['HOME']
    end
  end
end

if File.exists?('../Vagrantfile.global')
  load '../Vagrantfile.global'
end

if File.exists?('Vagrantfile.local')
  load 'Vagrantfile.local'
end

# Creates an initial user
$provisionUser = <<SCRIPT
chef-server-ctl user-create \
#{Classroom::ConfigManagement::Admin::username} \
#{Classroom::ConfigManagement::Admin::firstname} \
#{Classroom::ConfigManagement::Admin::lastname} \
#{Classroom::ConfigManagement::Admin::email} \
#{Classroom::ConfigManagement::Admin::password} \
--filename #{Classroom::ConfigManagement::Admin::username}.pem
SCRIPT

# Creates an initial organization
$provisionOrganization = <<SCRIPT
chef-server-ctl org-create \
#{Classroom::ConfigManagement::Organization::shortName} \
"#{Classroom::ConfigManagement::Organization::longName}" \
--association_user #{Classroom::ConfigManagement::Admin::username}
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  if Classroom::ConfigManagement::Box::ipAddress.nil?
    config.vm.network "private_network", type: "dhcp"
  else
    config.vm.network "private_network", ip: Classroom::ConfigManagement::Box::ipAddress
  end

  # Disable the default rsync shared folder configured by the centos/7 boxes Vagrantfile
  config.vm.synced_folder ".", "/home/vagrant/sync", type: "rsync", :disabled => true

  # Mount an NFS shared folder if configured
  if (!Classroom::ConfigManagement::Box.syncDirHost.nil? && !Classroom::ConfigManagement::Box.syncDirGuest.nil?)
    config.vm.synced_folder Classroom::ConfigManagement::Box::syncDirHost,
      Classroom::ConfigManagement::Box::syncDirHost,
      type: 'nfs',
      :nfs_version => Vagrant::Util::Platform.windows? ? 3 : 4,
      :nfs_udp => Vagrant::Util::Platform.windows? ? true : false,
      :mount_options => ['nolock']
  end

  Classroom::ConfigManagement.ports.each do |guestPort, hostPort|
    config.vm.network "forwarded_port", guest: hostPort, host: guestPort
  end

  config.vm.provision "shell", path: 'setup.sh'
  config.vm.provision "shell", inline: $provisionUser
  config.vm.provision "shell", inline: $provisionOrganization

end
