#!/usr/bin/env bash

echo VAGRANT BOOTSTRAP Waiting for MongoDB to start...
sleep 10s

# creare mongo tables and indexes
mongo /vagrant/mongodb/create_db.js