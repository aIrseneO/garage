#! /bin/bash/

# Use the wget command to retrieve the latest stable version of phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz

# To verify the GPG key for phpMyAdmin, download the phpMyAdmin keyring
wget https://files.phpmyadmin.net/phpmyadmin.keyring

# Import the keyring
gpg --import phpmyadmin.keyring

# Download the corresponding GPG .asc file for your version of phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz.asc

# Verify the .asc file against the keyring downloaded
gpg --verify phpMyAdmin-latest-english.tar.gz.asc

# Remove the GPG key for phpMyAdmind and the GPG .asc file 
rm -f phpmyadmin.keyring phpMyAdmin-latest-english.tar.gz.asc

# Unpack the phpMyAdmin tar.gz files
tar xvf phpMyAdmin-latest-english.tar.gz > /dev/null

# Remove the tar.gz file
rm -f phpMyAdmin-latest-english.tar.gz

# Rename the phpmyadmin file
mv -f phpMyAdmin* phpmyadmin

# Create a default configuration file
cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php

# Edit the default configuration file with sed app
sed -i "s/blowfish_secret'] = ''/blowfish_secret'] = '$1'/1" \
			phpmyadmin/config.inc.php

# TODO change the permissions for the config.inc.php file
#chmod 660 phpmyadmin/config.inc.php

# TODO change the ownership of the phpmyadmin directory
#chown -R user:group phpmyadmin

# Move phpmyadmin to localhost
mv -f phpmyadmin /var/www/localhost/phpmyadmin

#	https://phoenixnap.com/kb/how-to-install-phpmyadmin-on-debian-10
