#!/usr/bin/env bash

echo VAGRANT SHUTDOWN Sopping Kafka...
/usr/local/bin/kafka/bin/kafka-server-stop.sh

echo VAGRANT SHUTDOWN Sopping Zookeeper...
/usr/local/bin/kafka/bin/zookeeper-server-stop.sh

echo VAGRANT SHUTDOWN Done