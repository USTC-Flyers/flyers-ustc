#!/usr/bin/bash
if [[ -z $1 ]]
then 
	echo No deploy path given, exiting...
	exit 1
fi
cd $1
git pull origin master
docker-compose build
docker-compose down
sleep 10
docker-compose up -d  --remove-orphans
