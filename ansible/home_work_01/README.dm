How to run these playbooks:

# Run Docker installation
ansible-playbook -i inventory install_docker.yml

# Run app config creation
ansible-playbook -i inventory create_app_config.yml

# Run backup user setup
ansible-playbook -i inventory create_backup_user.yml

# Run rsync setup (make sure rsync.conf.j2 is in templates/ directory)
ansible-playbook -i inventory setup_rsync.yml

# Or run all playbooks sequentially
for playbook in install_docker.yml create_app_config.yml create_backup_user.yml setup_rsync.yml; do
    ansible-playbook -i inventory $playbook
done







Directory structure needed:
ansible/
├── install_docker.yml
├── create_app_config.yml
├── create_backup_user.yml
├── setup_rsync.yml
├── templates/
│   └── rsync.conf.j2
└── inventory (your hosts file)








# Gather all facts about localhost
ansible -i inventory_local localhost -m setup

# Gather specific facts about Docker
ansible -i inventory_local localhost -m setup -a "filter=ansible_docker*"

# Gather facts about users
ansible -i inventory_local localhost -m setup -a "filter=ansible_user*"

# Gather facts about packages
ansible -i inventory_local localhost -m setup -a "filter=ansible_packages*"






check_status.yml

ansible-playbook -i inventory_local verify_all.yml










Quick one-liner status check:
# Check everything at once
echo "=== Docker ===" && docker --version && \
echo "=== Docker Service ===" && systemctl status docker --no-pager | grep Active && \
echo "=== Backuper User ===" && id backuper && \
echo "=== Backups Directory ===" && ls -la /opt/backups && \
echo "=== App Config ===" && ls -la /opt/demo_app/config/ && \
echo "=== Rsync ===" && rsync --version | head -1 && \
echo "=== Rsync Config ===" && ls -la /etc/rsync.d/





