#!make
SHELL = /bin/sh

export DOCKER_BUILDKIT = 1

DC = docker
ORGANIZATION = materya
REGISTRY = ghcr.io
REPOSITORY = https://github.com/materya/containers
BASE_IMAGE = ghcr.io/materya/pywine-3.8

branches := 4 5
name := metatrader

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): image = $(ORGANIZATION)/$(name)
$(branches): version = $@
$(branches):
	@echo "Building $(image):$(version) ..."
	@$(DC) build --pull \
		--cache-from $(image):latest \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(REPOSITORY) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg MT_VERSION=$(version) \
		-t $(image):latest \
		-t $(image):$(version) \
		-t $(REGISTRY)/$(image):latest \
		-t $(REGISTRY)/$(image):$(version) \
		-f Dockerfile \
		.

.PHONY: clean
clean: image := $(REGISTRY)/$(name)
clean:
	@$(DC) rmi -f \
		$$($(DC) images --filter=reference="$(image)" --format="{{.ID}}") \
		2>/dev/null \
		|| echo "No image found matching \"$(image)\""

.PHONY: push
push: image := $(ORGANIZATION)/$(name)
push:
	@$(DC) push -a $(image)
	@$(DC) push -a $(REGISTRY)/$(image)
