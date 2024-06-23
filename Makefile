PROJECT_MODE ?= dev
PROJECT_NAME ?= frankenphp-sylius-$(PROJECT_MODE)

# Executables (local)
ifeq ($(PROJECT_MODE), prod)
DOCKER_COMP = \
	APP_SECRET=password \
	CADDY_MERCURE_JWT_SECRET=password \
	IMAGE_NAME=$(PROJECT_NAME) \
	docker compose -p $(PROJECT_NAME) -f compose.yaml -f compose.prod.yaml
else
DOCKER_COMP = \
	IMAGE_NAME=$(PROJECT_NAME) \
	docker compose -p $(PROJECT_NAME) -f compose.yaml -f compose.override.yaml
endif

# Docker containers
NODE_CONT = $(DOCKER_COMP) exec node
PHP_CONT  = $(DOCKER_COMP) exec php

# Executables
NPM      = $(NODE_CONT) npm
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer
SYMFONY  = $(PHP) bin/console

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up down start restart logs sh bash test composer vendor sf cc setup load_samples build_assets

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach --wait

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

start: build up ## Build and start the containers
restart: down up ## Stop and start the containers

clean: ## Remove unused data (keep volumes)
	docker system prune --all --force

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the FrankenPHP container
	@$(PHP_CONT) sh

bash: ## Connect to the FrankenPHP container via bash so up and down arrows go to previous commands
	@$(PHP_CONT) bash

test: ## Start tests with phpunit, pass the parameter "c=" to add options to phpunit, example: make test c="--group e2e --stop-on-failure"
	@$(eval c ?=)
	@$(DOCKER_COMP) exec -e APP_ENV=test php bin/phpunit $(c)

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf

## —— Application 🎲 ———————————————————————————————————————————————————————————
setup: ## Launching project by environment
	make start
	make load_samples
	make build_assets

load_samples: ## Filling the database with dummy data
ifeq ($(PROJECT_MODE), prod)
	make sf c='sylius:install --no-interaction'
else
	make sf c='sylius:install --no-interaction --fixture-suite=default'
endif

build_assets: ## Build optimized frontend data by environment
ifeq ($(PROJECT_MODE), prod)
	docker run --rm -v $(shell pwd):/app -w /app node:lts-alpine sh -c 'npm ci; npm run build'
	rm -rf 'node_modules/'
else
	@$(NPM) ci
	@$(NPM) run dev
endif
