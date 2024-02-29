#! /bin/bash
#
# SERVER
#
#	groupadd -g 42042 share
#	mkdir -p /home/export/nfs
#	chown [nfsnobody | nobody] /home/export
#	chgrp -R share /home/export
#	chmod -R 0770 /home/export
#
#	systemctl [start | status ...] nfs-server
#
#	/etc/exports
#		/home/export/nfs <Network/mask>(options) 127.0.0.1/32(rw)
#
#	/etc/default/
#		#RPCMOUNTDOPTS="--manage-gids"
#		RPCMOUNTDOPTS="-p 24422"
#	
#	iptables -t filter -I INPUT -p tcp --dport 111 -j ACCEPT
#	iptables -t filter -I INPUT -p udp --dport 111 -j ACCEPT
#	iptables -t filter -I INPUT -p tcp --dport 2049 -j ACCEPT
#	iptables -t filter -I INPUT -p udp --dport 2049 -j ACCEPT
#	iptables -t filter -I INPUT -p tcp --dport 24422 -j ACCEPT
#	iptables -t filter -I INPUT -p udp --dport 24422 -j ACCEPT
#	
#	ufw allow from 192.168.X.X/X to any port 111
#	ufw allow from 192.168.X.X/X to any port 2049
#	ufw allow from 192.168.X.X/X to any port 24422
#
#	firewall-cmd --permanent --add-service=mountd
#	firewall-cmd --permanent --add-service=nfs
#	firewall-cmd --permanent --add-service=rpc-bind
#
#	Tuning:
#	/sys/module/nfs/parameters/nfs4_disable_idmapping
#		Y/N
#	nfsidmap [option]
#	systemctl [option] nfs-idmapd
#	
# Install:
#	CentOs: nfs-utils
#	OpenSuse: nfs-utils nfs-kernel-server
#	Debian: nfs-kernel-server
#____________________________________________________________________________
# CLIENT
#
#	groupadd -g 42042 share
#	mkdir -p /home/share/nfs
#	usermod -aG share _user_
#
#	showmount -e server
#	mount server:/share /mnt/share
#
#	/etc/fstab
#		server:/home/export/nfs /home/share/nfs nfs _netdev 0 0
#
# Install:
#		Debian: nfs-common
#_____________________________________________________________________________
#	By the default `root_squash` is on (server side), it maps requests from
# uid/gid 0 (usually root - client side) to the anonymous uid/gid (server side).
# `all_sqush` by default off, does it for all uids and gids.
#
#	Reference(s):
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/deployment_guide/s1-nfs-security
