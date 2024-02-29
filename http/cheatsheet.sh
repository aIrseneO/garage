#! /bin/bash
# SERVER
# Create and delete Users for secure connection
#	htpasswd -c mysecure.users _id_
#	echo _passwd_ | htpasswd -i -c mysecure.users _id_
#	htpasswd -D mysecure.users _id_
#
# Enable Basic Authentification module on Ubuntu
#	cd /etc/apache2/mods-enabled; ln -s ../mods-available/auth_basic.load .
#	a2enmod auth_basic
#	a2enmod cgi
#	a2enmod rewrite
#	a2enmod status
#	a2enmod include
#	a2enmod proxy_html
#	a2enmod proxy_http
#	a2enmod lbmethod_byrequests
#
# Correct the context for a directory on Centos
#	chcon -R --reference=_Default_ _Created_
#
#	yum install mod_ssl # CentOS
#
# Create SSL key and certificates
#	man req #/example
# key:
#	openssl genrsa -aes128 -out _mykey.key_ 2048
#	openssl genrsa -aes128 2048 > _mykey.key_
#
# Self-Signed Certificate:
#	openssl req -utf8 -new -key _mykey.key_ -x509 -days 365 -out _mycert.crt_ -set_serial 0
#
# Certificate Signing Request: (To be signed by a Certificate Authority)
#	openssl req -utf8 -new -key _mykey.key_ -out _mycert.crt_
#
#	chmod +x *.cgi
#	chmod +x */magic/index.html
#
# Magic
# <!--#include virtual="/includes/mypage.html" -->
#_______________________________________________________________________________
# CLIENT
#	lynx -dump server
#	lynx -dump -auth=_id_:_passwd_ server/secure
#	lynx -dump server/script/file.cgi?ls
#	lynx -dump server/server-status
#	lynx -dump server/server-status/auto
#	lynx -dump server/index.html
# Check Self-Signed certificate website with web browser
#	

