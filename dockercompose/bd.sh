#! /bin/sh

MYSQL_ROOT_PASSWORD=pass
MYSQL_DATABASE=mydb
MYSQL_USER=medb
MYSQL_PASSWORD=mepw

docker pull mysql
docker run -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -e MYSQL_DATABASE=${MYSQL_DATABASE} -e MYSQL_USER=${MYSQL_USER} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} --name db -d mysql
#docker exec -it db bash

docker pull wordpress
docker run --name wordpress --link db:mysql -p 4242:80 -d -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_USER=${MYSQL_USER} -e WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD} -e WORDPRESS_DB_NAME=${MYSQL_DATABASE} wordpress
#docker exec -it wp bash

docker pull phpmyadmin
docker run --name myadmin -d --link db:mysql -p 2121:80 phpmyadmin
#docker exec -it myadmin bash
