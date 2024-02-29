#! /bin/bash
#
# SERVER
#
#	getsebool -a|grep rsync
#
#	setsebool rsync_full_access=on
#	firewall-cmd --zone=public --add-port=rsync/tcp
#
#	man rsync
#	man rsyncd.conf
#
# Install:
#_______________________________________________________________________________
# CLIENT
#
# Over rsync protocol
#	rsync [options] [_user_@]server::default /dest
# Over ssh protocol
#	rsync [options] [_user_@]server:/src /dest
#
# Install:
#
