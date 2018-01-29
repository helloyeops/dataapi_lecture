#!/bin/bash

DPCORE_NAME=core-module-hadoopbatch
BASEDIR=$(dirname "$0")
BASEDIR=`cd ${BASEDIR}/;pwd`

## 01. process check
PIDS=`ps -ef | grep ${DPCORE_NAME} | grep java | awk '{print $2}'`
if [ "$PIDS" > 0 ]; then
  echo "An API Server (${DPCORE_NAME}) process already exists. Stop the process first."
  exit 0
fi

nohup $BASEDIR/startup.sh > /dev/null &
PIDS=`ps aux | grep ${DPCORE_NAME} | grep java | awk '{print $2}'`

if [ "$PIDS" == 0 ]; then
  echo "API Server (${DPCORE_NAME}) has not been started."
else
  echo "API Server (${DPCORE_NAME}) has started completely."
fi