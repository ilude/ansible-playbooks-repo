	
run: setup
	ansible-playbook main.yml

setup:
	pip install -r /app/config/requirements.txt
	ansible-playbook /app/config/install-requirements.yml