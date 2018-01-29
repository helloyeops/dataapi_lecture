

#!bin/bash

#PWD=`pwd`
BASEDIR=$(dirname "$0")
BASEDIR=`cd ${BASEDIR}/;pwd`


#echo $PWD


## 01. api server stop
sh ${BASEDIR}/api-stop.sh

## 02. wait for server stop
echo "wait 10 seconds for restart"
sleep 10

## 03. wait for server stop
sh ${BASEDIR}/api-start.sh

echo "API Server has restarted completely"

