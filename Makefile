# Define shell to use
SHELL := /bin/bash

COMPOSE := docker compose -f srcs/docker-compose.yml

default: up

# Start up services
up:
	$(COMPOSE) up -d --build

# Pause services
pause:
	$(COMPOSE) pause

# Restart services
restart:
	$(COMPOSE) restart

# Stop services
down:
	$(COMPOSE) down

# Stop services and remove volumes
down-v:
	$(COMPOSE) down -v

# Stop services, remove volumes and images
down-all:
	$(COMPOSE) down -v --rmi all

# Show logs
logs:
	$(COMPOSE) logs -f

# Show logs for a specific service (e.g., make logs-wordpress)
logs-%:
	$(COMPOSE) logs -f $*

# Access shell inside a container (e.g., make shell-wordpress)
shell-%:
	$(COMPOSE) exec $* /bin/sh

# Execute a command inside a running container (e.g., make exec service=wordpress cmd="ls")
exec:
	$(COMPOSE) exec $(service) $(cmd)

# Remove all images
rmi:
	docker rmi -f $(shell docker images -q)

# Remove all volumes
rmv:
	docker volume rm $(shell docker volume ls -q)

# Remove all networks
rmn:
	docker network rm $(shell docker network ls -q)

# Remove all containers
rmc:
	docker rm -f $(shell docker ps -a -q)

# Remove all images, volumes, networks and containers
clean: down-all rmi rmv rmn rmc


.PHONY: default up down down-v down-all restart logs logs-% shell-% exec rmi rmv rmn rmc clean