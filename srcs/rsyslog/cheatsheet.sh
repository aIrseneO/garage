#! /bin/bash
#
# SERVER
#
#	systemctl start rsyslog
#	man rsyslog.conf
#
#	/etc/rsyslog.conf | /etc/rsyslog.d/remote.conf
#		module(load="imudp")
#		input(type="imudp" port="514")
#		module(load="imtcp")
#		input(type="imtcp" port="514")
#		module(load="imrelp")
#		input(type="imrelp" port="601")
#					or	(on RPM Based System)
#		$ModLoad imudp
#		$UDPServerRun 514
#		$ModLoad imtcp
#		$InputTCPServerRun 514
#		$ModLoad imrelp
#		$InputRELPServerRun 601
#
#	/etc/rsyslog.d/00-myfiler.conf
#		:FROMHOST-IP, isequal, "client1" -/log_file
#		& ~
#		:FROMHOST-IP, isequal, "client2" -/log_file
#		& ~
#				or
#		if $fromhost-ip == 'client' then {
#			action(type="omfile" file="/log_file")
#			stop
#		}
#		...
#
# Install:
#	rsyslog
#	omrelp module
#		[yum | apt | zypper | dnf] search rsyslog | grep relp
#		[yum | apt | zypper | dnf] install [rsyslog-relp | rsyslog-module-relp]
#_______________________________________________________________________________
# CLIENT
#
#	logger -n server message
#
#	systemctl start rsyslog
#	man rsyslog.conf
#
#	/etc/rsyslog.conf
#		module(load="omrelp")
#					or
#		$ModLoad omrelp
#
#	/etc/rsyslog.d/00-share-with-server.conf
#		*.* @server:514
#		*.* @@server:514
#		*.* :omrelp:@server:601
#		
# Install:
#	rsyslog
#	omrelp module
#		[yum | apt | zypper | dnf] search rsyslog | grep relp
#		[yum | apt | zypper | dnf] install [rsyslog-relp | rsyslog-module-relp]
