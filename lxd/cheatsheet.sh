#! /bin/bash
#
# SERVER
#
#	lxc-create --name mycontainer --template download \
#		-- [-d ubuntu] [-r focal] [-a amd64] [--no-validate]
#	lxc-ls [--fancy | --active | --running | --stopped | --frozen | ...]
#	lxc-destroy --name container --force
#	lxc-start --name mycontainer --daemon
#	lxc-attach --name mycontainer -- [command]
#	lxc-copy --name mycontainer -N mycontainer_copy
#	lxc-clone mycontainer mycontainer_copy
#	...
#	
#	systemctl [status | start ...] [lxc | lxc-net | libvirtd]
#
# Install:
#	Debian: lxc
#	CentOs:
#		CentOs 7: libvirt*
#			/etc/lxc/default.conf
#				lxc.network.type = veth
#				lxc.network.link = virbr0
#				lxc.network.flags = up
#			/etc/sysconfig/lxc.net
#				USE_LXC_BRIDGE="true"
#				LXC_BRIDGE="virbr0"
#			/etc/NetworkManager/conf.d/10-managed-devices-override.conf
#				[device]
#				match-device=interface-name:veth*,virbr0-nic
#				managed=1
#
#			epel-release perl wget bridge-utils
#			debootstrap libvirt libcap-devel libcgroup
#			lxc lxc-templates lxc-extra
#
#		CentOs 8: lxc lxc-templates lxcfs lxc-doc lxc-libs
#			/etc/sysconfig/lxc-net
#				USE_LXC_BRIDGE="true"
#				LXC_BRIDGE="lxcbr0"
#				LXC_ADDR="10.0.3.1"
#				LXC_NETMASK="255.255.255.0"
#				LXC_NETWORK="10.0.3.0/24"
#				LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
#				LXC_DHCP_MAX="253"
#				LXC_DHCP_CONFILE=""
#				LXC_DOMAIN=""
#_______________________________________________________________________________
# CLIENT
#
# Install:
#	Debian: 
#	CentOs: 
