#!/usr/bin/env bash

# Reload local package database
sudo apt-get update

echo VAGRANT BOOTSTRAP Installing Java, if not yet installed...

# Install Java
sudo apt-get install -y openjdk-8-jre
# Pin the packages at the currently installed versions to prevent unintended upgrades
echo "openjdk-8-jre hold" | sudo dpkg --set-selections

echo VAGRANT BOOTSTRAP Installing Scala, if not yet installed...

# Install Scala
sudo apt-get install -y scala
# Pin the packages at the currently installed versions to prevent unintended upgrades
echo "scala hold" | sudo dpkg --set-selections

# Install Kafka if not yet installed
# Look inside kafka dir, since it's the one we create ourselves
# We are actually interested in its content
if ! [ -d /usr/local/bin/kafka/bin ]; then
	if ! [ -d /usr/local/download ]; then
	  mkdir /usr/local/download
	fi
	cd /usr/local/download
	if ! [ -f kafka_2.12-2.1.0.tgz ]; then
		sudo wget -q http://apache.belnet.be/kafka/2.1.0/kafka_2.12-2.1.0.tgz
	fi
	tar xvzf kafka_2.12-2.1.0.tgz
	if [ -d kafka ]; then
	  rm -rf kafka
	fi
	mv kafka_2.12-2.1.0 kafka
	if ! [ -d /usr/local/bin/kafka ]; then
		mkdir /usr/local/bin/kafka
	fi
	mv kafka /usr/local/bin
fi

# Move to kafka dir
cd /usr/local/bin/kafka

# Create our own folder for kafka logs
if ! [ -d /vagrant/kafka1/kafka-logs ]; then
  mkdir /vagrant/kafka1/kafka-logs
fi

# Point kafka logs to our folder
# Usage: ln -sf /path/to/file /path/to/symlink
if ! [ -L /usr/local/bin/kafka/logs ]; then
  rm -rf /usr/local/bin/kafka/logs
  ln -fs /vagrant/kafka1/kafka-logs /usr/local/bin/kafka/logs
fi

# Install kafkacat
sudo apt-get install -y librdkafka-dev libyajl-dev
sudo apt-get install -y kafkacat

# Copy kafka configuration
cp /vagrant/kafka1/server.properties /usr/local/bin/kafka/config/server.properties

# Copy zookeeper1 configuration
cp /vagrant/kafka1/zookeeper1.properties /usr/local/bin/kafka/config/zookeeper1.properties
cp /vagrant/kafka1/zookeeper2.properties /usr/local/bin/kafka/config/zookeeper2.properties

# Set up zookeeper1 id
mkdir -p /tmp/zookeeper1
echo "1" > /tmp/zookeeper1/myid

# Set up zookeeper2 id
mkdir -p /tmp/zookeeper2
echo "2" > /tmp/zookeeper2/myid

# Start Zookeeper1
echo VAGRANT BOOTSTRAP Starting Zookeeper1...
bin/zookeeper-server-start.sh -daemon config/zookeeper1.properties

# Start Zookeeper2
echo VAGRANT BOOTSTRAP Starting Zookeeper2...
bin/zookeeper-server-start.sh -daemon config/zookeeper2.properties

# Start Kafka
echo VAGRANT BOOTSTRAP Starting Kafka...
bin/kafka-server-start.sh -daemon config/server.properties

echo VAGRANT BOOTSTRAP Done