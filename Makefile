DOCKER_COMPOSE				= docker-compose
DOCKER_COMPOSE_FILE		= srcs/docker-compose.yml
DOCKER_COMPOSE_FLAGS	= -f $(DOCKER_COMPOSE_FILE) -p inception
SRCS_DIR = srcs
VPATH = srcs


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
	rm -rf	srcs/mariadb/data/*
	rm -f		srcs/wordpress/wp-config.php

fclean: clean
	@sh 		srcs/tools/reset_server_ip.sh
	rm -f ~/data
	rm -f wordpress.tar.gz
	rm -rf $(SRCS_DIR)/wordpress

dependencies: $(SRCS_DIR)/wordpress/ ~/data
ifeq ($(shell uname -s), Linux)
	@sh srcs/tools/set_server_ip.sh
endif
	@echo "Checking dependencies is done"

~/data:
	ln -s $(abspath $(SRCS_DIR))/mariadb/data/ ~/data

$(SRCS_DIR)/wordpress/: wordpress.tar.gz adminer.php
	@echo "Extracting wordpress..."
	@tar -xf $< -C $(SRCS_DIR)
	@mv adminer.php $@/

adminer.php:
	@echo "Downloading adminer..."
	@curl -L -o $@ https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php


wordpress.tar.gz:
	@echo "Downloading wordpress..."
	@curl -o $@	https://wordpress.org/wordpress-6.0.tar.gz
