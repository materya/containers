#!make

# Activate Docker BuildKit
DOCKER_BUILDKIT = 1
# Using BuildKit in compose
COMPOSE_DOCKER_CLI_BUILD = 1

# COMMANDS
DOCKER = docker

CONFIGFILE = .config
ifneq (,$(wildcard $(CONFIGFILE)))
	include $(CONFIGFILE)
	export $(shell sed 's/=.*//' $(CONFIGFILE))
endif

# VARS
IMAGE = $(REGISTRY)/$(NAME)
VERSION = $(PYTHON_VER)-$(IMAGE_BASE)

.PHONY: all
all: build push

.PHONY: help
help:
	@echo "Makefile arguments:"
	@echo ""
	@echo "IMAGE_BASE - Which OS to build on [alpine, buster-slim]"
	@echo "PYTHON_VER - Python version"
	@echo "TALIB_VER - TA Lib version"
	@echo ""
	@echo "Makefile commands:"
	@echo ""
	@echo "all - don't need an explanation"
	@echo "build - build the docker image locally"
	@echo "push - push the docker image to the registry"

.PHONY: build
build:
	@$(DOCKER) build --pull \
		--build-arg PYTHON_VER=$(PYTHON_VER) \
		--build-arg TALIB_VER=$(TALIB_VER) \
		--cache-from $(IMAGE):latest \
		--cache-from $(IMAGE):$(VERSION) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t $(IMAGE):$(VERSION) \
		-t $(IMAGE):latest \
		-f Dockerfile.$(IMAGE_BASE) \
		.

.PHONY: push
push:
	@$(DOCKER) push -a $(IMAGE)
