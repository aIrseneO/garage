#! /bin/sh

# Install Linux Standard Base to identify the Linux distribution being used
apt-get -y install lsb-release

# Install gnupg for mysql config
apt-get -y install gnupg

# Set answer for 
debconf-set-selections debconf_file

# Download the configuration file for mysql
wget https://repo.mysql.com//mysql-apt-config_0.8.15-1_all.deb

# Install the configuration file and delete it
echo "4" | dpkg -i mysql-apt-config_0.8.15-1_all.deb
rm -f mysql-apt-config_0.8.15-1_all.deb

# Update
apt-get -y update

# Activate the noninteractive mode of debian
export DEBIAN_FRONTEND="noninteractive"

# Install MySQL server
apt-get -y install mysql-server
# Start MySQL
service mysql start
# Setup MySQL directory structure
mysql_install_db
# Secure the installation
bash mysql_secure_installation.sh
