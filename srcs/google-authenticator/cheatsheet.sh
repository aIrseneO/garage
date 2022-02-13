#! /bin/bash
#
# SERVER
#	Remote
#
#____________________________________________________________________________
# CLIENT
#
#	/etc/pam.d/sshd
#		auth required pam_google_authenticator.so
#
#	/etc/ssh/sshd_config
#		ChallengeResponseAuthentication yes
#
#	systemctl restart sshd
#
#	google-authenticator
#
# Install:
#	Debian: libpam-google-authenticator
#	CentOs: 
#
# Reference:
#  https://ubuntu.com/tutorials/configure-ssh-2fa#1-overview
