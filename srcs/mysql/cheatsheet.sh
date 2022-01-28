#! /bin/bash
#
# SERVER
#
#	systemctl start mariadb
#	mysql_secure_installation
#		Set root password
#		Remove anonymous-users
#		Remove test database and access to it
#	mysqladmin -u root -p version
#	mysql -u root --password=_password_
#		CREATE USER 'facko'@'%' IDENTIFIED BY 'password';
#		SELECT USER, HOST FROM mysql.user;
#		CREATE DATABASE db;
#		SHOW DATABASES;
#		GRANT ALL PRIVILEGES ON db.* TO 'user42'@'%';
#		USE db;
#
#		CREATE TABLE animals (
#			id SMALLINT NOT NULL AUTO_INCREMENT,
#			name VARCHAR(12) NOT NULL,
#			foods VARCHAR(60) NOT NULL,
#			number INT NOT NULL,
#			useless varchar(20),
#			PRIMARY KEY (id) );
#		SHOW TABLES;
#		SHOW FULL TABLES;
#		DESC animals;
#		INSERT INTO animals (id,name,foods,number, useless) VALUES
#			(1,'Buffalo','Grass, oilcakes, hay, grains',2,'will be delete'),
#			(2,'cat','rat, birds, milk',9,'will be delete'),
#			(3,'lion','Flesh of other animals',1,'will be delete'),
#			(4,'intruder','pizza',42,'will be delete'),
#			(5,'tiger','Flesh of other animals',3,'will be delete'),
#			(6,'spider','insects',13,'will be delete');
#		SELECT * FROM animals;
#		DROP TABLE Animals;
#		DROP DATABASE db;
#		DELETE FROM animals WHERE id = 4;
#		ALTER TABLE animals DROP COLUMN useless;
#
# Install:
#	mariadb-server
#_______________________________________________________________________________
# CLIENT
#
#	Connect to a remote server
#		mysql -u _userName_ -h _server_ -p
# Install:
#	mariadb
#
