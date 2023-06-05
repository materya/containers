#!/usr/bin/env make

SHELL = /usr/bin/env sh

include ../../make/env.mk

VERSIONS = ./Versions
include $(VERSIONS)

DOCKER = /usr/bin/env docker

branches := 3.6 3.7 3.8 3.9
name := pywine

IMAGE_REPOSITORY = $(REGISTRY)/$(ORG)/$(name)
BASE_IMAGE = $(REGISTRY)/$(ORG)/wine-stable

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): image = $(IMAGE_REPOSITORY)-$@
$(branches): version = $($@_version)
$(branches):
	@echo "Building $(image):$(version) ..."
	@$(DOCKER) build --pull \
		--cache-from $(image):latest \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(CODE_REPOSITORY) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg PY_VERSION=$(version) \
		-t $(image):latest \
		-t $(image):$(version) \
		-f Dockerfile \
		.

.PHONY: clean-branch
clean-branch: BRANCH := 3.9
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
push-branch: BRANCH := 3.9
push-branch: image := $(IMAGE_REPOSITORY)-$(BRANCH)
push-branch:
	@$(DOCKER) push -a $(image)

.PHONY: push
push:
	@for branch in $(branches) ; do $(MAKE) push-branch BRANCH=$$branch ; done
