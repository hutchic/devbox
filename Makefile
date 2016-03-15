run_ansible:
	ansible-galaxy install -r requirements.yml
	ansible-playbook playbook.yml -i vagrant_ansible_inventory_default --ask-vault-pass
