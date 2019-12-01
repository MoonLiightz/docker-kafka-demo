DOCKER_NETWORK=kafka-demo
ZOOKEEPER_HOST=zookeeper:2181
KAFKA_HOST=kafka
BROKER=broker1:9092,broker2:9092,broker3:9092

# Include and overwrite env File
include .env

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  up                  Create and start containers"
	@echo "  down                Stop and clear all services"
	@echo "  start               Start containers"
	@echo "  stop                Stop containers"
	@echo "  logs                Follow log output"
	@echo "  ps                  List containers"
	@echo "  create-network      Create docker network"
	@echo "  update-env          Write the first three octets of the docker netwrok ip adress in the .env file"
	@echo "  kafka-shell         Start a kafka shell"
	@echo "  reset               Reset directories"
	@echo "  clean               Clean directories for reset and remove all containers and networks"

up: docker-compose.yml .env
	docker-compose up -d

down: docker-compose.yml .env
	docker-compose down -v

start: docker-compose.yml .env
	docker-compose start

stop: docker-compose.yml .env
	docker-compose stop

logs: docker-compose.yml .env
	docker-compose logs -f

ps: docker-compose.yml .env
	docker-compose ps

create-network: .env
	docker network create ${DOCKER_NETWORK}

update-env: .env
	scripts/update-env.sh

kafka-shell: .env
	scripts/start-kafka-shell.sh ${KAFKA_HOST} ${ZOOKEEPER_HOST} ${BROKER}

reset:
	make down
	rm -Rf data

clean: .env
	make reset
	docker network rm ${DOCKER_NETWORK}
