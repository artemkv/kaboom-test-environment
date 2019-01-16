#!/usr/bin/env bash

echo VAGRANT BOOTSTRAP Installing mongodb, if not yet installed...

# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 2>&1

# Create a list file for MongoDB (tee overwrites output file by default)
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Reload local package database
sudo apt-get update

# Install the MongoDB packages (if already installed, will do nothing)
sudo apt-get install -y mongodb-org=4.0.5 mongodb-org-server=4.0.5 mongodb-org-shell=4.0.5 mongodb-org-mongos=4.0.5 mongodb-org-tools=4.0.5

# Pin the packages at the currently installed versions to prevent unintended upgrades
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Create our own folder for mongo db logs
# We cannot do the same for data directory, since mongodb does not support it
if ! [ -d /vagrant/mongodb/mongodb-log ]; then
  mkdir /vagrant/mongodb/mongodb-log
fi

# Point mongo db logs to our folder
# Usage: ln -sf /path/to/file /path/to/symlink
if ! [ -L /var/log/mongodb ]; then
  rm -rf /var/log/mongodb
  ln -fs /vagrant/mongodb/mongodb-log /var/log/mongodb
fi

# Copy mongodb configuration
cp /vagrant/mongodb/mongod.conf /etc/mongod.conf

echo VAGRANT BOOTSTRAP Starting MongoDB...

# Start MongoDB
sudo service mongod start

echo VAGRANT BOOTSTRAP Done