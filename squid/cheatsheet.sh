#! /bin/bash
#
# SERVER
#
#	grep -v "^#" /etc/squid/squid.conf|grep -v "^$"
#	squid -k parse
#	squid -k reconfigure
#	systemctl restart squid
#
#	/etc/squid/squid.conf	
#		acl mynetwork src _network_/_mask_
#		http_access allow mynetwork
#		
#		acl sites_blocked url_regex ˆhttp://.*xxx.xxx/.*$
#		http_access deny sites_blocked
#
# Install:
#	squid
#_______________________________________________________________________________
# CLIENT
#
#	/etc/lynx.cfg
#		http_proxy:http://server:port
#	lynx -dump server
#
# Install:
#	lynx
