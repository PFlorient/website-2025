-include infra/.env infra/.env.local

MAKEFLAGS += --no-print-directory
TAG    := $(shell git describe --tags --abbrev=0 2> /dev/null || echo 'latest')
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest

COMPOSE_FILE ?= infra/docker/compose.yml
ifneq ("$(wildcard infra/docker/compose.override.yml)","")
    COMPOSE_FILE := infra/docker/compose.yml:infra/docker/compose.override.yml
endif
DOCKER_COMPOSE := COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose
NPM := $(DOCKER_COMPOSE) run --rm node npm

export APP_URL COMPOSE_FILE COMPOSE_PROJECT_NAME SERVER_NAME OUTPUT_PORT ENVIRONMENT_TYPE RELAY_HOST RELAY_PORT RELAY_USERNAME RELAY_PASSWORD

### Docker

up: ## Démarre les containers
	$(DOCKER_COMPOSE) up  -d

stop: ## Stop les containers
	$(DOCKER_COMPOSE) stop

down: ## Supprime les containers
	$(DOCKER_COMPOSE) down

restart: ## Relance les containers
	$(DOCKER_COMPOSE) restart

build: ## Build les différentes images
	$(eval service :=)
	$(eval target :=)
	$(target) $(DOCKER_COMPOSE) build $(service) --no-cache

exec: ## Connexion au container node
	$(eval c := node)
	$(eval cmd := sh)
	$(DOCKER_COMPOSE) exec  $(c) $(cmd)

run: ## Démarre un container
	$(eval c := node)
	$(eval cmd := sh)
	$(DOCKER_COMPOSE) run --rm --no-deps $(c) $(cmd)

npm-install: ## Lance yarn install
	$(NPM) cache clean
	$(NPM) install

nuxt-build: ## Build l'appli nuxt
	$(NPM) run build

init: ## Initialise le projet
	$(MAKE) build nuxt-build
	$(MAKE) up


dev: ## Démarre l'appli nuxt
	$(npm) run dev

server-prod: ##Lance le serveur de prod de l'application Nuxt
	$(DOCKER_COMPOSE) run --rm node .output/server/index.mjs

infra/docker/compose.override.yml:
	cp infra/docker/compose.override.yml.dist infra/docker/compose.override.yml
