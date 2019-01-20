#!/usr/bin/env bash

echo VAGRANT BOOTSTRAP Waiting for MongoDB replication setup...
sleep 30s

# create mongo tables and indexes
mongo /vagrant/mongodb-common/create_db.js