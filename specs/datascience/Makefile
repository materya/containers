#!/usr/bin/env make

SHELL = /usr/bin/env sh

include ../../make/env.mk

DOCKER = /usr/bin/env docker

NAME=datascience

IMAGE_BASE = buster-slim
PYTHON_VER = 3.8
TALIB_VER = 0.4.0

IMAGE_REPOSITORY = $(REGISTRY)/$(ORG)/$(NAME)
VERSION = $(PYTHON_VER)-$(IMAGE_BASE)

.PHONY: all
all: build

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
		--cache-from $(IMAGE_REPOSITORY):latest \
		--cache-from $(IMAGE_REPOSITORY):$(VERSION) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t $(IMAGE_REPOSITORY):$(VERSION) \
		-t $(IMAGE_REPOSITORY):latest \
		-f Dockerfile.$(IMAGE_BASE) \
		.

.PHONY: push
push:
	@$(DOCKER) push -a $(IMAGE_REPOSITORY)
