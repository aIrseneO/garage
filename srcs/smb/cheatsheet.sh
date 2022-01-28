#! /bin/bash
#
# SERVER
#
#	mkdir -p /home/export/cifs/{public,download,private}
#	groupadd --system smbgroup
#	useradd --system --no-create-home --group smbgroup -s /bin/false smbuser
#
#	chown -R smbuser:smbgroup /home/export/cifs
#
#	usermod -aG smbgroup _user_ #private user
#
#	chmod 0775 /home/export/cifs
#	chmod -R 0777 /home/export/cifs/public
#	chmod -R 0770 /home/export/cifs/private
#	chmod -R 0755 /home/export/cifs/download
#
#	smbpasswd -a _user_ #private
#	/var/lib/samba/private/smbpasswd
#	pdbedit -Lv
#	
#	/root/smbcredentials
#		username=_user_
#		password=_password_
#	chmod 0600 /root/smbuser
#	mount -t cifs 
#
#	testparm
#
#	systemctl [start | status ...] [smb | smbd]
#
# Install:
#	Debian: samba
#	OpenSuse: samba
#	CentOs: samba samba-common
#_______________________________________________________________________________
# CLIENT
#
#	mkdir -p /home/share/cifs/{private,public,download}
#	testparm
##	useradd --system --no-create-home --group smbgroup -s /bin/false smbuser
#	smbclient -L server [-U smbuser]
#	smbclient -U vagrant //server/_exports_
#	mount -t cifs -o username=_user_,password=_password_,[uid=xxx,gid=xxx] //suse/public /home/share/cifs/public
#	mount -o credentials=/root/smbcredentials //suse/private /home/share/cifs/private
#
#	/etc/fstab
#		//192.168.40.12/download /home/share/cifs/download cifs _netdev,credentials=/root/smbcredentials 0 0
#
# Install:
#	Debian: smbclient cifs-utils
#	OpenSuse: samba-client cifs-utils
#	CentOs: samba-client samba-common cifs-utils
#
#	Reference(s):
# https://ubuntu.com/server/docs/samba-securing
