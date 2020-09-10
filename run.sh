#! /bin/sh

# Create the image of the container
docker build -t ft_server_image .

# Run the container
docker run --name ft_server_container -p 80:80 -p 443:443 ft_server_image
#docker run --name ft_server_container -p 80:80 -p 443:443 -v ${PWD}/srcs/.:/root/ ft_server_image

# Open the container
#docker exec -it ft_server_container bash

# Usefull commamds
#docker start ft_server_container
#docker stop ft_server_container
#docker attach ft_server_container
#docker kill ft_server_container
#docker rm ft_server_container
#docker rmi ft_server_image
