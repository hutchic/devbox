# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder '..', '/src', :nfs => true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
  
  config.vm.network "private_network", ip: "33.33.33.35"
  config.vm.provision :shell, :path => "bootstrap.sh"
end
