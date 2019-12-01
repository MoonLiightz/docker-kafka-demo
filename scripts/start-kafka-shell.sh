#!/bin/bash
set -a
. ./.env
set +a

docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --network $DOCKER_NETWORK \
  -e HOST_IP=$1 \
  -e ZK=$2 \
  -e BROKERS=$3 \
  wurstmeister/kafka /bin/bash
