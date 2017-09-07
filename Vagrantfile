# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION=2
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.define "webserver"
  config.vm.hostname = "webserver"
  config.vm.network "private_network", ip: "33.33.33.33"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.linked_clone = true
  end

  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "inventory.ini"
    ansible.playbook = "playbook.yml"
    ansible.sudo = true
    ansible.verbose = "v"
  end
end
