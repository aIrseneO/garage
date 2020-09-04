# Get the system required to run the server 
FROM debian:buster

# Update the system and install dependencies
#	expect to automate responses
#	wget to download packages
#	Nginx to setup the web server
#	MariaDB to handle MySQL database
#	php7.3-fpm (Fast Process Manager) to handle php scripts from the web-server
#	php7.3-mysql to hallow php to talk to MySQL database
#	php7.3* to handle php web pages
RUN apt-get -y update \
	&& apt-get -y install 	expect \
							wget \
							nginx \
							mariadb-server \
							php7.3 php7.3-cli php7.3-cgi php7.3-mbstring \
							php7.3-fpm php7.3-mysql

# Expose ports of the container to ease communication with the host machine
# Port 80 is the default port for web browser
EXPOSE 80
# Port 443 is the default port for ssl connection, to secure web pages
EXPOSE 443

# Copy the source files from the host machine to the new system
COPY srcs ./root/

# Change directory to the root of the new system
WORKDIR /root/

# Using bash run the script to launch the server
ENTRYPOINT ["bash"]
