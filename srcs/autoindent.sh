#! /bin/bash

# Set autoindex on/off according to the input
if [ "$1" = "on" ]
then
	sed -i "s/autoindex .*;/autoindex on;/1" /etc/nginx/sites-available/localhost
	rm /var/www/localhost/index.html
elif [ "$1" = "off" ]
then
	sed -i "s/autoindex .*;/autoindex off;/1" /etc/nginx/sites-available/localhost
	cp /root/web/index.html /var/www/localhost/
fi

# Restart nginx
service nginx reload
service nginx status
