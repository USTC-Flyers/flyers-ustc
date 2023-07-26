#!/usr/bin/bash
if [[ -z $1 ]]
then 
	echo No deploy path given, exiting...
	exit 1
fi
cd $1
git pull origin master
docker network rm $(docker network ls -q)
docker-compose down
# docker-compose build
docker-compose up -d
