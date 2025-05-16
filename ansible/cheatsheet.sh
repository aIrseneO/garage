#! /bin/bash
#
# SERVER
#
# Install:
#
#
#____________________________________________________________________________
# CLIENT
#   Create role (vm):
#       ansible-galaxy role init vm
#       ansible-galaxy role import airseneo ansible-role-vm --token <token> -v
#       ansible-galaxy role delete --token <token> -v airseneo ansible-role-vm
#
#   Upgrade role (vm):
#       git tag 2.0.0
#       git push origin --tags
#       ansible-galaxy role import --token <token> -v airseneo ansible-role-vm

#   Create collection (vm):
#       ansible-galaxy collection init vm
#       ansible-galaxy collection import airseneo ansible-role-vm --token <token> -v
#       ansible-galaxy collection delete --token <token> -v airseneo ansible-role-vm
#
#
# Install:
#_____________________________________________________________________________
#
#	Reference(s):
#       https://docs.ansible.com/ansible/latest/galaxy/dev_guide.html#creating-collections-for-galaxy
