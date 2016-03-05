# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1404-desktop"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "4048"
  end

  required_plugins = %w( vagrant-guest_ansible )
  required_plugins.each do |plugin|
    system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
  end

  #config.vm.provision "shell", inline: "ansible-galaxy install -r /vagrant/requirements.yml"

  if Vagrant::Util::Platform.windows?
    config.vm.provision :guest_ansible do |guest_ansible_setup|
      guest_ansible_setup.playbook = "setup.yml"
    end
  else
    config.vm.provision :ansible do |ansible_setup|
      ansible_setup.playbook = "setup.yml"
    end
  end

  if Vagrant::Util::Platform.windows?
    config.vm.provision :guest_ansible do |guest_ansible|
      guest_ansible.playbook = "playbook.yml"
    end
  else
    config.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end

  config.vm.network "private_network", ip: "33.33.33.35"
end
