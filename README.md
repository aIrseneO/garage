#   Ft_server

Ft_server is a web server running in a Docker Container on Debian Buster. It uses Nginx and runs multiples services: WordPress, phpMyAdmin and SQL database(MariaBD). A Selfsigned certificate is used for security.<br>

![Illustration](srcs/web/img.png)

#   How to use?

A recent version of Docker running on any Linux distribution is required to launch the server.

At the root of the repository, Run the script 
```bash
./run.sh
```
Wait until all installations are completed.