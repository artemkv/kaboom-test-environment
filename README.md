Kaboom Test Environment

Vagrant file for MongoDB and Kafka.
Unlike in dev environment, kafka is exposed on the static, not localhost, which makes it available to the containers running in the k8s pods.

Access MongoDB at 192.168.60.50:27017

Access Kafka at 192.168.60.51:9092
Check server properties using:

```
vagrant ssh kafka
kafkacat -b 192.168.60.51:9092 -L
```

Use "vagrant up" to bring it up