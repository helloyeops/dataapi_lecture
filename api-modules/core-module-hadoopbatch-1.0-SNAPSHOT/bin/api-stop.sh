#!/bin/bash

DPCORE_NAME=core-module-hadoopbatch
BASEDIR=.

## 01. process check
PIDS=`ps -ef | grep ${DPCORE_NAME} | grep java | awk '{print $2}'`
if [ -z $PIDS ]
then
 echo "Server already stop"
 exit 0
fi

echo "kill server Process ID "$PIDS""
for PID in $PIDS
do
kill $PID
echo "kill the server Process ID is : $PID "
done

## 02. wait for server stop
echo "wait 10 seconds for server stopping completely"
sleep 10

## 03. check server process
CHK=`ps -ef | grep ${DPCORE_NAME} | grep java | awk '{print $2}'`

if [ -z $CHK ]
then
 echo "Server stop complete"
 rm -rf $BASEDIR/.vertx
 rm $BASEDIR/0
else
 echo "Warning : Server still working"
fi

exit 0