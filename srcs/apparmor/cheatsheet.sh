#! /bin/bash
#
#	List profile with their status
#		aa-status
#		cat /sys/kernel/security/apparmor/profiles
#	Create a profile for an existing program
#		aa-genprof test.sh
#	Get the created profile file
#		ls /etc/apparmor.d/ | grep test.sh
#		sudo find /etc/apparmor.d/ -name "*test.sh" -exec cat {} \;
#	Disable a profile
#		apparmor_parser -R /etc/apparmor.d/<profile>
#		ln -s /etc/apparmor.d/<profile> /etc/apparmor.d/disable/
#	Enable a profile
#		apparmor_parser /etc/apparmor.d/<profile>
# 
# Install:
#			apparmor-utils
