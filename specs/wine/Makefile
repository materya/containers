#!/usr/bin/env make
SHELL = /bin/sh

export DOCKER_BUILDKIT = 1

VERSIONS = ./Versions
include $(VERSIONS)

DOCKER = /usr/bin/env docker
ORGANIZATION = materya
REGISTRY = ghcr.io
REPOSITORY = https://github.com/materya/containers

branches := stable staging devel
name := wine

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): image = $(ORGANIZATION)/$(name)-$@
$(branches): version = $(shell echo $($@_version) | sed 's/~.*//')
$(branches):
	@echo "Building $(image):$(version) ..."
	@$(DOCKER) build --pull \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(REPOSITORY) \
		--build-arg WINE_BRANCH=$@ \
		--build-arg WINE_VERSION=$($@_version) \
		--cache-from $(image):latest \
		-t $(image):latest \
		-t $(image):$(version) \
		-t $(REGISTRY)/$(image):latest \
		-t $(REGISTRY)/$(image):$(version) \
		-f Dockerfile \
		.

.PHONY: clean-branch
clean-branch: BRANCH := stable
clean-branch: image := $(REGISTRY)/$(name)-$(BRANCH)
clean-branch:
	@$(DOCKER) rmi -f \
		$$($(DOCKER) images --filter=reference="$(image)" --format="{{.ID}}") \
		2>/dev/null \
		|| echo "No image found matching \"$(image)\""

.PHONY: clean
clean:
	@for branch in $(branches) ; do $(MAKE) clean-branch BRANCH=$$branch ; done

.PHONY: push-branch
push-branch: BRANCH := stable
push-branch: image := $(ORGANIZATION)/$(name)-$(BRANCH)
push-branch:
	@$(DOCKER) push -a $(image)
	@$(DOCKER) push -a $(REGISTRY)/$(image)

.PHONY: push
push:
	@for branch in $(branches) ; do $(MAKE) push-branch BRANCH=$$branch ; done
