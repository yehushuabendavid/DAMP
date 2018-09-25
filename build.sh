#!/bin/bash
if [ "$( id -u)" != "0" ]; then	echo "Need to ROOT"; exit; fi
if [ "$( which docker)" == "" ]; then echo "Docker not found"; exit; fi
echo "--------------BUILD DockerApache2MysqlPHP -------------"
echo -n "Enter the password for root user (system & mysql) [rootpw] ?"
read RPW
if [ "Y$RPW" == "Y" ];       then RPW="rootpw" ; fi
docker build --build-arg PASSWORD=$RPW -t damp .
echo -n "Run it [Y] ?"
read DORUNIT
if [ "Y$DORUNIT" == "Y" ];	 then 	DORUNIT="Y" ; fi
if [ "${DORUNIT^^}" == "YES" ] ; then 	DORUNIT="Y" ; fi
if [ "$DORUNIT" != "Y" ] ;	 then 	echo "You can run it like this:";echo "docker run -it -p 8080:80 -p 2222:22 damp bash startAll.sh";exit;fi
echo -n "Select the localhost port for HTTP [8080] ?"
read PHTTP
echo -n "Select the localhost port for SSH [2222] ?"
read PSSH

if [ "$PHTTP" == "" ] ; then PHTTP=8080 ; fi
if [ "$PSSH" == "" ] ; then PSSH=2222 ; fi

docker run -it -p $PHTTP:80 -p $PSSH:22 --rm --name damptest damp /startAll.sh





