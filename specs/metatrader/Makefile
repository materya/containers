#!/usr/bin/env make

SHELL = /usr/bin/env sh

include ../../make/env.mk

DOCKER = /usr/bin/env docker

branches := 4 5
name := metatrader

IMAGE_REPOSITORY = $(REGISTRY)/$(ORG)/$(name)
BASE_IMAGE = $(REGISTRY)/$(ORG)/pywine-3.8

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): version = $@
$(branches):
	@echo "Building $(IMAGE_REPOSITORY):$(version) ..."
	@$(DOCKER) build --pull \
		--cache-from $(IMAGE_REPOSITORY):latest \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(CODE_REPOSITORY) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg MT_VERSION=$(version) \
		-t $(IMAGE_REPOSITORY):latest \
		-t $(IMAGE_REPOSITORY):$(version) \
		-f Dockerfile \
		.

.PHONY: clean
clean:
	@$(DOCKER) rmi -f \
		$$($(DOCKER) images --filter=reference="$(IMAGE_REPOSITORY)" --format="{{.ID}}") \
		2>/dev/null \
		|| echo "No image found matching \"$(IMAGE_REPOSITORY)\""

.PHONY: push
push:
	@$(DOCKER) push -a $(IMAGE_REPOSITORY)
