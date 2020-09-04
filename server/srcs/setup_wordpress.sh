#! /bin/bash/

# Download the latest WordPress
wget http://wordpress.org/latest.tar.gz > /dev/null

# Untar the downloaded WordPress' file
tar xfz latest.tar.gz > /dev/null

# Remove the tar file
rm -f latest.tar.gz

# Create a config file based on the given sample
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Edit the config file using sed app
#	Set the name of the database for WordPress
sed -i "s/database_name_here/$1/" wordpress/wp-config.php

#	Set MySQL database username
sed -i "s/username_here/$2/" wordpress/wp-config.php

#	Set MySQL database password
sed -i "s/password_here/$3/" wordpress/wp-config.php

# TODO Change the permissions for the wp-config.php file
#chmod 660 wordpress/wp-config.php

# TODO Change the ownership of the wordpress directory
#chown -R user:group wordpress

# Move WordPress to localhost
mv -f wordpress /var/www/localhost/wordpress.com
