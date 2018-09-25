#!/bin/bash
if [ "$( id -u)" != "0" ]
	then
		echo "Need to ROOT"
		exit
fi

if [ "$( which docker)" == "" ] 
	then
		echo "Docker not found"
		exit
fi 

echo "--------------BUILD DockerApache2MysqlPHP -------------"
docker build -t damp .

