#! /bin/bash
#
# SERVER
#
#	/usr/share/doc/tgt/examples/targets.conf.example.gz    <- example conf
#
#	# /etc/tgt/conf.d/iqn.2022-02.myserver.com.conf
#		<target iqn.2020-03.com.linuxhint:data>
#			backing-store /dev/sdb
#			initiator-name iqn.2022-02.com.example:initiator
#			incominguser myusername mysecretpassword
#		</target>
#	
# Install:
#	Debian: tgt
#	targetcli-fb
#____________________________________________________________________________
# CLIENT
#
#	/etc/iscsi/initiatorname.iscsi
#		InitiatorName=iqn.2022-02.com.example:initiator
#
#	/etc/iscsi/iscsid.conf
#		node.session.auth.username = myusername
#		node.session.auth.password = mysecretpassword
#
#	# Get the target name:
#		iscsiadm --mode discovery --type sendtargets --portal <server IP>
#
#	# Establish the connection and associate  the block device
#		iscsiadm --mode node --targetname <name> --portal <server IP> --login
#
#	# Logout
#		iscsiadm --mode node --targetname <name> --portal <server IP> --logout
#
# Install:
#	Debian: open-iscsi
#	CentOs: iscsi-initiator-utils
