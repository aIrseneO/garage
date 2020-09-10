#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: atemfack <marvin@42.fr>                    +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2020/09/09 11:15:53 by atemfack          #+#    #+#             *#
#*   Updated: 2020/09/09 11:58:39 by atemfack         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

IMAGE_NAME=ft_server_image

CONTAINER_NAME=ft_server_container

all:
					docker build -t $(IMAGE_NAME) .
					docker run --name $(CONTAINER_NAME) -p 80:80 -p 443:443 \
							$(IMAGE_NAME)

image:
					docker build -t $(IMAGE_NAME) .

container:
					docker run --name $(CONTAINER_NAME) -p 80:80 -p 443:443 \
							$(IMAGE_NAME)

vcontainer:
					docker run --name $(CONTAINER_NAME) -p 80:80 -p 443:443 \
							-v ${PWD}/srcs/.:/root/ $(IMAGE_NAME)


open:
					docker exec -it $(CONTAINER_NAME) bash

start:
					docker start $(CONTAINER_NAME)

stop:
					docker stop $(CONTAINER_NAME)

attach:
					docker attach $(CONTAINER_NAME)

kill:
					docker kill $(CONTAINER_NAME)

rm:
					docker rm $(CONTAINER_NAME)

rmi:
					docker rmi $(IMAGE_NAME)
