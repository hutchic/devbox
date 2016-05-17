run_ansible:
	sudo ansible-galaxy install -p galaxy -r /vagrant/requirements.yml
	ansible-playbook -vvvvv playbook.yml -i vagrant_ansible_inventory_default --ask-vault-pass
