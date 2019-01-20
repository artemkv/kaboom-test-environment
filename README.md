Kaboom Test Environment

Vagrant file for MongoDB and Kafka.

Mongo runs in a cluster of 2, in master-slave setup.
Access MongoDB at mongodb://192.168.60.50:27017,192.168.60.51:27017

Check Mongo using:

```
rs.status()
```

Kafka runs in a cluster of 2.
Access Kafka at 192.168.60.50:9092,192.168.60.51:9092

Zookeeper runs in a cluster of 3, to achieve the consensus.
(Kafka will not start until the Zookeeper quorum is not available.)
Zookeepers: 192.168.60.50:2181,192.168.60.50:2182,192.168.60.51:2181

Check Kafka cluster using:

```
vagrant ssh kafka
kafkacat -b 192.168.60.50:9092 -L
kafkacat -b 192.168.60.51:9092 -L
```

Check zookeeper cluster using:

```
telnet 192.168.60.50 2181
stat

telnet 192.168.60.50 2182
stat

telnet 192.168.60.51 2181
stat
```

Use "vagrant up" to bring it up