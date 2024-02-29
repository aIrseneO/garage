#! /bin/bash
#
# SERVER
#
#	nft list tables
#	nft list table [family]  tableName
#	nft add  table [family] tableName
#			family: ip (default), ip6, inet, arp, bridge, netdev
#	nft delete table [family] tableName
#
#	nft list chains
#	nft list chain  [family] tableName chainName
#	nft add  chain  [family] tableName chainName [ { type type hook hook
#		[device device] priority priority ; [policy policy;] } ]
#			type: filter, nat, route
#			hook: input, output, prerouting, postrouting
#
#	nft [add | insert] rule [family] table chain [position position] statement..
#
#	nft flush ruleset
#	nft add table mytable
#	nft add chain inet mytable mychain {type filter hook input priority 0\; }
#	nft add rule inet mytable mychain ct state established,related accept
#	nft add rule inet mytable mychain iifname lo accept
#	nft add rule inet mytable mychain tcp dport 22 accept
#	nft add rule inet mytable mychain counter
#	nft add rule inet mytable mychain drop
#
#	nft list ruleset [ > [ /etc/nftables.conf | /etc/nftables/mynft.conf ] ]
#
#	systemctl [start | status ...] nftables
#
# Install:
#	nftables
#_______________________________________________________________________________
# CLIENT
#
# Install:
#
