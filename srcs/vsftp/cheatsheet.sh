#! /bin/bash
#
# SERVER
#
#	Ubuntu & OpenSuse: UPLOADS=/srv/ftp/uploads
#	Centos: UPLOADS=/var/ftp/uploads
#
#	mkdir -m 730 UPLOADS
#	chown root:ftp UPLOADS
#
#	/etc/vsftpd.conf:
#		anonymous_enable=YES
#		anon_upload_enable=YES
#		write_enable=YES
#		local_enable=NO
#		anon_root=/var/ftp/
#		no_anon_password=YES
#		hide_ids=YES
#		pasv_min_port=40000
#		pasv_max_port=50000
#		....
#
# Check selinux boolean(s) to allow for ftp upload
#	semanage boolean -l | grep ftpd
#
#	firewall-cmd --zone=public --add-port=ftp/tcp
#	setsebool ftpd_full_access=on
#
# Install:
#	vsftpd 
#_______________________________________________________________________________
# CLIENT
#
#	ftp server
#	ftp -p server
#		[ ftp | anonymous ]
#		help
#		
# Install:
#		Ubuntu & CentOs:
#	ftp
#		OpenSuse:
#	tnftp
