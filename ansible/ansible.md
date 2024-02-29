# Garage

## Install package
```bash
sudo yum install ansible

sudo yum install epel-release
sudo yum install python-pip
sudo pip install ansible
sudo pip install --upgrade ansible

sudo pip install ansible==2.4
```

## Ansible config file
```bash
ansible-playbook -i inventory playbook.yml -K
ansible-config list
ansible-config view
ansible-config dump

# Generate a fully commented-out example ansible.cfg file:
ansible-config init --disabled > ansible.cfg
# Generate complete file that includes existing plugins:
ansible-config init --disabled -t all > ansible.cfg
```
## Ansible command
```bash
# Gather localhost facts
ansible -m setup localhost

# Ping host
ansible -m ping localhost
ansible <hostname> -m setup -i inventory.yml 

# Ad hoc command
ansible -a "<command>" host/all

# yaml inventory from classic
ansible-inventory -i inventory -y --list > i.yaml 

# install collection
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install kubernetes.core
```

## Playbook
```yaml
---
- name: hello World!
  hosts: localhost
  tasks:
  - set_fact:
      myvar: "Hello world!"
  - debug:
      var: myvar
```