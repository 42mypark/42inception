DOCKER_COMPOSE				= docker-compose
DOCKER_COMPOSE_FILE		= srcs/docker-compose.yml
DOCKER_COMPOSE_FLAGS	= -f $(DOCKER_COMPOSE_FILE) -p inception
SRCS_DIR = ./srcs
VPATH = ./srcs


.PHONY: help dependencies up start stop restart status ps clean build build-up

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

up: dependencies ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up $(c)

build: dependencies ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) build $(c)

build-up: build up

start: dependencies ## Start all or c=<name> containers in background
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up -d $(c)

stop: ## Stop all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) stop $(c)

restart: dependencies ## Restart all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) stop $(c)
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) up $(c) -d

logs: ## Show logs for all or c=<name> containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) logs --tail=100 -f $(c)

status: ## Show status of containers
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) ps

ps: status ## Alias of status

down: ## Clean all data
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) down

config: ## Show docker-compose config
	@$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FLAGS) config

clean: down
	rm -rf	srcs/mariadb/data/*
	rm -f		srcs/wordpress/wp-config.php

fclean: clean
	rm -f wordpress.tar.gz
	rm -rf $(SRCS_DIR)/wordpress

dependencies: $(SRCS_DIR)/wordpress
	@echo "Checking dependencies is done"

$(SRCS_DIR)/wordpress: wordpress.tar.gz
	@echo "Extracting wordpress..."
	@tar -xf $< -C $(SRCS_DIR)
 
wordpress.tar.gz:
	@echo "Downloading wordpress..."
	@curl -o $@  https://wordpress.org/latest.tar.gz