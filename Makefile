DOCKER_COMPOSE				= sudo docker-compose
DOCKER_COMPOSE_FILE		= srcs/docker-compose.yml
DOCKER_COMPOSE_FLAGS	= -f $(DOCKER_COMPOSE_FILE) -p inception

DB_VOLUME_NAME	= data
DB_VOLUME_DIR		= /home/mypark/$(DB_VOLUME_NAME)
WP_TAR 					= wordpress.tar.gz
WP_VOLUME_NAME	= wordpress
WP_VOLUME_DIR		= $(shell pwd)/$(WP_VOLUME_NAME)

RM = sudo rm -rf

SRCS_DIR	= srcs
VPATH			= srcs


.PHONY: help dependencies up start stop restart status ps clean build build-up volume

help:
	@echo usage: make [target]
	@echo "start		Start all containers in background"
	@echo "build		Build all containers"
	@echo "up   		Start all containers in background"
	@echo "build-up 	Start all containers with build"
	@echo "stop		Stop all containers"
	@echo "status		Show status of containers"
	@echo "restart		Restart of containers"
	@echo "ps		Alias of status"
	@echo "down		Clean all data"
	@echo "config		docker-compose config"

build-up: build up

build-start: build start

up: ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up

build: dependencies ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) build

start: ## Start all or c=<name> containers in background
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up -d

stop: ## Stop all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) stop

restart: ## Restart all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) stop
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up -d

logs: ## Show logs for all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) logs --tail=100 -f

down: ## Clean all data
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) down

config: ## Show docker-compose config
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) config

clean: down
	@sh 		srcs/tools/reset_server_ip.sh
	@$(RM)		$(DB_VOLUME_DIR)
	@$(RM)		$(WP_VOLUME_DIR)
	@$(RM) 		$(WP_TAR)
	@sudo docker volume rm $(DB_VOLUME_NAME) > /dev/null
	@sudo docker volume rm $(WP_VOLUME_NAME) > /dev/null

dependencies: volume
ifeq ($(shell uname -s), Linux)
	@sh srcs/tools/set_server_ip.sh
endif
	@echo "Checking dependencies is done"

volume: $(DB_VOLUME_DIR) $(WP_VOLUME_DIR)/adminer.php $(WP_TAR) 
	@sudo docker volume create --name $(DB_VOLUME_NAME) -d local --opt type=none --opt device=$(DB_VOLUME_DIR) --opt o=bind > /dev/null
	@sudo docker volume create --name $(WP_VOLUME_NAME) -d local --opt type=none --opt device=$(WP_VOLUME_DIR) --opt o=bind > /dev/null
	@sudo docker volume ls | head -1 && sudo docker volume ls | grep $(DB_VOLUME_NAME) && sudo docker volume ls | grep $(WP_VOLUME_NAME)
	@make -t $^

$(WP_VOLUME_DIR)/adminer.php: $(WP_VOLUME_DIR)
	@echo "Downloading adminer..."
	@curl -L -o $(WP_VOLUME_DIR)/adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php

$(WP_TAR): $(WP_VOLUME_DIR)
	@echo "Downloading wordpress..."
	@curl -o $@	https://wordpress.org/wordpress-6.0.tar.gz
	@echo "Extracting wordpress..."
	@tar -xf $@ -C $(WP_VOLUME_DIR) --strip-component=1


$(WP_VOLUME_DIR):
	@echo "Making wordpress volume directory..."
	@mkdir -p $@

$(DB_VOLUME_DIR):
	@echo "Making database volume directory..."
	@mkdir -p $@

