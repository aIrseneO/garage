#! /bin/bash
#
# SERVER
#	/etc/chrony.conf
#
#	/etc/ntp.conf
#
#	systemctl start [ntp.service | chronyd.service]
#	
# Install:
#	Debian: ntp
#____________________________________________________________________________
# CLIENT
#
#	chronyc sources -v
#	chronyc tracking
#	chronyc sourcestats -v
#
#	ntpdate -q server
#
#	systemctl stop ntp.service
#	ntpdate server
#	systemctl start ntp.service
#
# Install:
#	Debian: ntpdate
