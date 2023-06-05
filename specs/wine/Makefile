#!/usr/bin/env make

SHELL = /usr/bin/env sh

include ../../make/env.mk

VERSIONS = ./Versions
include $(VERSIONS)

DOCKER = /usr/bin/env docker

branches := stable staging devel
name := wine

IMAGE_REPOSITORY = $(REGISTRY)/$(ORG)/$(name)
BASE_IMAGE = $(REGISTRY)/$(ORG)/wine-stable

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): image = $(IMAGE_REPOSITORY)-$@
$(branches): version = $(shell echo $($@_version) | sed 's/~.*//')
$(branches):
	@echo "Building $(image):$(version) ..."
	@$(DOCKER) build --pull \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(CODE_REPOSITORY) \
		--build-arg WINE_BRANCH=$@ \
		--build-arg WINE_VERSION=$($@_version) \
		--cache-from $(image):latest \
		-t $(image):latest \
		-t $(image):$(version) \
		-f Dockerfile \
		.

.PHONY: clean-branch
clean-branch: BRANCH := stable
clean-branch: image := $(IMAGE_REPOSITORY)-$(BRANCH)
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
push-branch: image := $(IMAGE_REPOSITORY)-$(BRANCH)
push-branch:
	@$(DOCKER) push -a $(image)

.PHONY: push
push:
	@for branch in $(branches) ; do $(MAKE) push-branch BRANCH=$$branch ; done
