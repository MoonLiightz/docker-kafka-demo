#!/bin/bash
set -a
. ./.env
set +a

grep -qF 'DOCKER_NETWORK_SUBNET_PRAEFIX=' .env || echo 'DOCKER_NETWORK_SUBNET_PRAEFIX=' >> .env
sed -i 's/DOCKER_NETWORK_SUBNET_PRAEFIX=.*/DOCKER_NETWORK_SUBNET_PRAEFIX='$(docker network inspect -f "{{range .IPAM.Config}}{{.Subnet}}{{end}}" ${DOCKER_NETWORK} | cut -d"." -f1-3)'/g' .env
