docker-kafka-demo
============

This repo contains a Dockerized demo setup of an Kafka environment.


## Components

- One Zookeeper
  - Version: 3.4.13
  - Docker Image: [wurstmeister/zookeeper:latest](https://github.com/wurstmeister/zookeeper-docker)
- Three Kafka Broker
  - Version: 2.3.0
  - Docker Image: [wurstmeister/kafka:2.12-2.3.0](https://github.com/wurstmeister/kafka-docker)
- Kafka Manager WebUI
  - Version: 2.0.0.2
  - Docker Image: [hlebalbau/kafka-manager:2.0.0.2](https://github.com/hleb-albau/kafka-manager-docker)


## Prerequisites

- Docker
- Docker Compose
- Make


## Installation

#### 1. Download or clone the files

```bash
$ git clone https://github.com/MoonLiightz/docker-kafka-demo.git
```

#### 2. Create an `.env` file

You can use the `.env.sample` file.
```bash
$ mv .env.sample .env
```

#### 3. Set the name of your docker network

Open your `.env` file and set the name of your docker network like the example.
```bash
DOCKER_NETWORK=kafka-demo
```

#### 4. (Optional) Create docker network

If the docker network you defined in the previous step does not exist, you have to create it.
```bash
$ make create-network
```

#### 5. Update env

This demo is configured with static IP addresses for the container, so we need to specify the first three octets of the docker network in the `.env` file. You can do it automatically.
```bash
$ make update-env
```

#### 6. Start container

Now it is time to bring the container up and running.
```bash
$ make up
```

Done. With `make ps` you should see something like that:
```bash
$ make ps                                                                 

            Name                           Command               State                  Ports                
-------------------------------------------------------------------------------------------------------------
docker-kafka-demo_broker1_1     start-kafka.sh                   Up      1099/tcp, 9092/tcp, 9094/tcp        
docker-kafka-demo_broker2_1     start-kafka.sh                   Up      1099/tcp, 9092/tcp, 9094/tcp        
docker-kafka-demo_broker3_1     start-kafka.sh                   Up      1099/tcp, 9092/tcp, 9094/tcp        
docker-kafka-demo_manager_1     /kafka-manager/bin/kafka-m ...   Up      9000/tcp                            
docker-kafka-demo_zookeeper_1   /bin/sh -c /usr/sbin/sshd  ...   Up      2181/tcp, 22/tcp, 2888/tcp, 3888/tcp

```

## Useful commands

```bash

# Print a list of available commands
$ make help

# Create and run the container
$ make up

# Stop and delete the container
$ make down

# Start the container
$ make start

# Stop the container
$ make stop

# Print logs in follow mode
$ make logs

# Print the container
$ make ps

# Create in DOCKER_NETWORK defined network
$ make create-network

# Write the first three octets of the in DOCKER_NETWORK 
# defined docker network ip address in the .env file
$ make update-env

# Start a kafka shell
$ make kafka-shell
# or
$ scripts/start-kafka-shell.sh <DOCKER_HOST_IP> <ZK_HOST:ZK_PORT> <BROKERS>

# Stop the container, delete them and remove the persistent files
$ make reset

# Calls the previous reset command and delete the DOCKER_NETWORK
$ make clean

```

## Play with Kafka

If you want to play with Kafka as described in the [Kafka Qickststart Guide](https://kafka.apache.org/quickstart), you can do it as follows.

#### Create a topic

```bash
# Start a kafka shell
$ make kafka-shell

# Go to kafka home directory
$ cd $KAFKA_HOME

# Create a topic
$ bin/kafka-topics.sh --create --topic test-topic \
  --partitions 4 --zookeeper $ZK --replication-factor 3

# Check the created topic
$ bin/kafka-topics.sh --describe --zookeeper $ZK --topic test-topic

```

#### Start a console producer

```bash
# Start a kafka shell
$ make kafka-shell

# Go to kafka home directory
$ cd $KAFKA_HOME

# Start a console producer
$ bin/kafka-console-producer.sh --broker-list $BROKERS --topic test-topic

```

#### Start a console consumer

```bash
# Start a kafka shell
$ make kafka-shell

# Go to kafka home directory
$ cd $KAFKA_HOME

# Start a console consumer
$ bin/kafka-console-consumer.sh --bootstrap-server $BROKERS --topic test-topic
```

## Notes

This setup does not publish ports to the host machine. If this is required, appropriate adjustments must be made in the `docker-compose.yml` file.


## Useful links

- [github.com/wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker)
- [Kafka connectivity](https://github.com/wurstmeister/kafka-docker/wiki/Connectivity)
- [Kafka Quickstart](https://kafka.apache.org/quickstart)

## License

docker-kafka-demo is released under the [MIT license](LICENSE).
