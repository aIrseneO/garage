#! /bin/bash
# SERVER
# Flushes the server's cache
#	rndc flush

# Dump the database, check the dump-file in the optins of `named.conf`
#	rndc dumpdb [-all|-cache|-zones|-adb|-bad|-fail]

# CHeck Configuration files
#	named-checkconf -z [named.conf]
#	man rndc
#	rndc reload
#_______________________________________________________________________________
# CLIENT
# Query the server for testing
#	dig @server -t [ A | AAAA | CNAME ... ] site
#	dig @server -x addr
#	host addr server
