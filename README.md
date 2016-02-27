# Configuration Management

## Contribution

### Development Environment
This repository ships with a Vagrant based development environment.

#### Setup with VirtualBox
You need to perform the following steps to use the development environment using VirtualBox:

1. Install [Vagrant](https://www.vagrantup.com/) >= 1.7.4
2. Install [VirtualBox](https://www.virtualbox.org/) >= 5.0
3. Install the [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest):
```
$ vagrant plugin install vagrant-vbguest
```

Now you can just `vagrant up` the virtual machine.

#### Configuration
You may add a `Vagrantfile.local` or `Vagrantfile.global` to override some defaults.
For further details see [Vagrantfile.local.dist](Vagrantfile.local.dist).
