#! /bin/sh

docker build -t ft_server_image .

docker run --name ft_server_container -it -v ${PWD}/srcs/.:/root/ -p 8080:80 ft_server_image
