#!/usr/bin/env bash
export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`

sed '1d' /etc/hosts > tmpHosts
cat tmpHosts > /etc/hosts
rm tmpHosts

cd /incubator-zeppelin/
cp -r -u ./provided-notebook/* ./notebook/
cp -r -u ./provided-libs/* ./libs/
./bin/zeppelin-daemon.sh start
#/bin/bash
sleep infinity

