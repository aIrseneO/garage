FROM debian:buster

RUN apt-get -y update \
	&& apt-get -y install 	expect wget mariadb-server \
							php7.3 php7.3-cli php7.3-cgi php7.3-mbstring \
							php7.3-fpm php7.3-mysql libnss3-tools nginx

COPY srcs ./root/

WORKDIR /root/

ENTRYPOINT ["bash"]

CMD ["launch_server.sh"]
