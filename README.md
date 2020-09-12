#   Ft_server

<div align="justify"> Ft_server is a web server running on Debian Buster in a Docker Container. It uses Nginx and runs multiples services: WordPress, phpMyAdmin and SQL database(MariaBD). A Selfsigned certificate is used for security.</div><br>

<div style="text-align:center"><img src="srcs/web/img.png" alt="Illustration"></div><br>

#   How to use?

A recent version of Docker running on any Linux distribution is required to launch the server.

At the root of the repository, Run the script 
```bash
./run.sh
```
Wait until all installations are completed. You should see the following

<div style="text-align:center"><img src="imgs/completed_installation.png" alt="installation completed"></div><br>

the server is up running and the present used terminal is waiting for logs from the launched webserver. In a web browser open **localhost**  
<div style="text-align:center"><img src="localhost.png" alt="Localhost"></div><br>  

the default precreated webpage will appear as follow
<div style="text-align:center"><img src="defaultIndex.png" alt="Default index"></div>  

Open another terminal, go the root of the repository and run the following command  

```bash
make open
```  
the terminal will switch to the terminal of the running container where configuration on the server can be done by the administrator. Run the foolowing command to deactivate the default webpage and activate autoindex  
```bash
./autoindex on
```  
reload the webpage, it should change to the following  

<div style="text-align:center"><img src=".png" alt="Autoindex"></div>  

The available websites are hence accessible via a click. **Crules** is a rough website created using html css and the framework bootsrap. Unlike others available websites, **Crules** is not connected to the database.