#! /bin/bash
#
# SERVER
#
#	mkdir -p GitShared/myworkdir
#	git init GitShared/myworkdir
#	touch /root/GitShared/myworkdir/git-daemon-export-ok
#
#	git daemon --max-connections=10 --port=4242 \
#				--base-path=/root/GitShared --base-path-relaxed \
#				--listen=0.0.0.0 --log-destination=syslog --verbose --detach \
#				--pid-file=/root/gitPid
#
#	man git-daemon
#
# Install:
#			git
#_______________________________________________________________________________
# CLIENT
#
#	git clone git://server:4242/myworkdir /workdir
#	git clone ssh://_user_@server/root/GitShared/myworkdir /workdir
#	git clone _user_@server/root/GitShared/myworkdir /workdir
#	git clone https://server/GitShared/myworkdir /workdir
#
#   git tag 1.0.0
#	git push --tags
#	git push origin 1.0.0
#
# Install:
#			git
