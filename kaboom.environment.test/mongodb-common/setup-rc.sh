#!/usr/bin/env bash

echo VAGRANT BOOTSTRAP Waiting for MongoDB to start...
sleep 10s

# configure replica set
mongo /vagrant/mongodb-common/setup-rc.js