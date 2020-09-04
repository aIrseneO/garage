#! /bin/sh

# Start nginx server
service nginx start

# Install MySQL server [Oracle version; needed if MariaDB-server isn't used]
#bash mysql_server_install.sh

# Password for MySQL root user
MYSQL_ROOT_PASSWORD=mysqlpassword

# Wordpresse database name
WP_DB_NAME=wpdb
# Wordpress database user name
WP_DB_USER=wpdbuser
# Password for wordpress database
WP_DB_PASSWORD=wpdbpassword

# Start MySQL
service mysql start
# Setup MySQL directory structure
#mysql_install_db
# Secure MySQL installation
bash mysql_secure_installation.sh ${MYSQL_ROOT_PASSWORD}

# Create a new database for wordpress
echo "CREATE DATABASE ${WP_DB_NAME};" | mysql -u root
echo "CREATE USER '${WP_DB_USER}';" | mysql -u root
echo "SET password FOR '${WP_DB_USER}' = \
			 password('${WP_DB_PASSWORD}');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'\
			 IDENTIFIED BY '${WP_DB_PASSWORD}';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# Make directory for WordPress and PhpMyAdmid files
mkdir /var/www/localhost

# Setup Wordpress
bash setup_wordpress.sh ${WP_DB_NAME} ${WP_DB_USER} ${WP_DB_PASSWORD}

# Setup PhpMyAdmin
bash setup_phpmyadmin.sh this_is_my_very_secret_passphrase

# Move the localhost site configuration file to Nginx
cp localhost_conf2 /etc/nginx/sites-available/localhost

# Move index.html to its location
cp index.html /var/www/localhost/

# Remove the default symbolic link to nginx welcome page
rm -f /etc/nginx/sites-enabled/default

# Create a symbolic link to activate localhost sites
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

# Generate Self signed certificate
bash ssl_key_crt_gen.sh

# Reload Nginx server to include new changes
service nginx reload

# Start php-fpm
/etc/init.d/php7.3-fpm start
/etc/init.d/php7.3-fpm status
