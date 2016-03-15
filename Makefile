run_ansible:
	sudo ansible-galaxy install -r /vagrant/requirements.yml
	ansible-playbook playbook.yml -i vagrant_ansible_inventory_default --ask-vault-pass
