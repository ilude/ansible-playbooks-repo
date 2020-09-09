
SUDOERS = /etc/sudoers.d/$USER
PWD = $(shell pwd)
ANSIBLE_CONFIG  = $(PWD)/config/ansible.cfg
export ANSIBLE_CONFIG

run: setup
	ansible-playbook main.yml

setup: $(SUDOERS) apt-upgrade install-pip3 install-ansible
	@echo Loading config $(ANSIBLE_CONFIG)
	ansible-playbook install-requirements.yml

$(SUDOERS):
	echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee --append $(SUDOERS)

apt-upgrade:
ifneq (1, $(shell sudo apt list --upgradable 2>/dev/null | wc -l))
	sudo apt update && sudo apt dist-upgrade -y
endif

install-pip3:
ifeq (, $(shell which pip3))
	sudo apt install python3 python3-pip #xorriso
endif

install-ansible:
ifeq (, $(shell which ansible))
	sudo pip3 install -r $(PWD)/config/requirements.txt
endif
