#! /bin/sh

# Start nginx server
service nginx start

mkdir /var/www/localhost

# Move the localhost site configuration file to Nginx
cp localhostssl /etc/nginx/sites-available/localhost

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
