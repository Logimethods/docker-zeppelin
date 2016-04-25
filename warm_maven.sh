#!/usr/bin/env bash
cd /incubator-zeppelin/
mvn clean package -Pspark-1.6 -Dspark.version=1.6.1 -DskipTests
