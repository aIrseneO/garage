#! /bin/bash

# Copy websites files to localhost 
cp -fr web/* /var/www/localhost/

# Update the welcome page with the database infos
sed -i "s/WP_DB_USER/$1/1" /var/www/localhost/index.html
sed -i "s/WP_DB_PASSWORD/$2/1" /var/www/localhost/index.html
