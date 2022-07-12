DOCKER_COMPOSE				= docker-compose
DOCKER_COMPOSE_FILE		= srcs/docker-compose.yml
DOCKER_COMPOSE_FLAGS	= -f $(DOCKER_COMPOSE_FILE) -p inception

DB_VOLUME_NAME	= data
DB_VOLUME_DIR		= /home/mypark/$(DB_VOLUME_NAME)
WP_TAR 					= wordpress.tar.gz
WP_VOLUME_NAME	= wordpress
WP_VOLUME_DIR		= $(shell pwd)/$(WP_VOLUME_NAME)

RM = rm -rf

SRCS_DIR	= srcs
VPATH			= srcs


.PHONY: help dependencies up start stop restart status ps clean build build-up volume

help:
	@echo usage: make [target]
	@echo "build		Build all containers"
	@echo "up   		Start all containers in foreground"
	@echo "start		Start all containers in background"
	@echo "stop		Stop all containers"
	@echo "down		Stop and Remove all containers"
	@echo "restart		Restart of containers"
	@echo "clean		Clean all containers and data"

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

down: ## Clean all data
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) down

clean: down
	@$(RM)		$(DB_VOLUME_DIR)
	@$(RM)		$(WP_VOLUME_DIR)
	@$(RM) 		$(WP_TAR)
	@docker volume rm $(DB_VOLUME_NAME) > /dev/null
	@docker volume rm $(WP_VOLUME_NAME) > /dev/null

dependencies: volume
	@echo "Checking dependencies is done"

volume: $(DB_VOLUME_DIR) $(WP_VOLUME_DIR)/adminer.php $(WP_TAR) 
	@docker volume create --name $(DB_VOLUME_NAME) -d local --opt type=none --opt device=$(DB_VOLUME_DIR) --opt o=bind > /dev/null
	@docker volume create --name $(WP_VOLUME_NAME) -d local --opt type=none --opt device=$(WP_VOLUME_DIR) --opt o=bind > /dev/null
	@docker volume ls | head -1 && docker volume ls | grep $(DB_VOLUME_NAME) && docker volume ls | grep $(WP_VOLUME_NAME)
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

