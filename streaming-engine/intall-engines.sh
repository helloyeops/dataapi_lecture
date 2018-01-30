#!/bin/bash
echo 'Initializing...'
hadoop fs -rm -r /user/spark/streaming 2>/dev/null
hadoop fs -mkdir -p /user/spark/streaming/driver
hadoop fs -mkdir -p /user/spark/streaming/lib

echo 'Installing...'
hadoop fs -put -f streaming-core-1.0-hdp263.jar /user/spark/streaming/driver/
hadoop fs -put -f phoenix-spark2-4.7.1-HBase1.1.jar /user/spark/streaming/lib/
hadoop fs -put -f mariadb-java-client-2.0.2.jar /user/spark/streaming/lib/

echo 'Install is completed...'
