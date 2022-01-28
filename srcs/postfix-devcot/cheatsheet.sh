#! /bin/bash
#
# SERVER
#
# Posfix configuration, `-d` can be used to check the value
#	postconf -e "inet_interfaces = all"
#	postconf -e "mynetworks_style = subnet"
#
#	postconf -e "smtpd_tls_auth_only = yes"
#	postconf -e "smtpd_tls_security_level = may"
#	postconf -e "smtpd_tls_cert_file = _postfix.pem_"
#	postconf -e "smtpd_tls_key_file = _postfix.pem_"

#	usermod -aG mail _user_
#
#	On Ubuntu check protocols: /usr/share/dovecot/protocols.d/
#	On Others update /etc/dovecot/dovecot.conf [protocols = imap pop3 lmtp]
#	update /etc/dovecot/dovecot.conf [listen = *, ::]
#	check [mail_location] /etc/dovecot/conf.d/10-mail.conf
#
#	usermod -aG mail _user_
#	find / -name mkcert.sh # To make certificate for dovecot
#
#	make -C /etc/pki/tls/certs posfix.pem # Centos
#
#
# Install:
#	postfix 
#		Ubuntu:
#	dovecot-imapd dovecot-pop3d dovecot-core dovecot-lmtpd
#		CentOs & OpenSuse:
#	dovecot
#_______________________________________________________________________________
# CLIENT
# Send mails
#	tenet _server_ 25
#		[helo, mail, rcpt, data.]
#	mail [options] user@localhost
#	
#	
# Check mails
#	mutt
#	mail -u _user_
#	mutt -f imap://_user_@<_server_>/
#
#	echo -en "\0_user_\0_password_" | base64
#
#	gnutls-cli --crlf --starttls --insecure --port 25 <IP ADDRESS>
#
# Install:
#	telnet, mutt
#		Ubuntu:
#			mailutils, gnutls-bin
#		CentOs & OpenSuse:
#			mailx, gnutls-utils (centos), gnutls (opensuse)
