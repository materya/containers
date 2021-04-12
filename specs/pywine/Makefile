#!make
SHELL = /bin/sh

export DOCKER_BUILDKIT = 1

VERSIONS = ./Versions
include $(VERSIONS)

DC = docker
REGISTRY = ghcr.io/materya
REPOSITORY = https://github.com/materya/containers
BASE_IMAGE = ghcr.io/materya/wine-stable

branches := 3.6 3.7 3.8 3.9
name := pywine

.PHONY: all
all: $(branches)

.PHONY: $(branches)
$(branches): image = $(REGISTRY)/$(name)-$@
$(branches): version = $($@_version)
$(branches):
	@echo "Building $(image):$(version) ..."
	@$(DC) build --pull \
		--cache-from $(image):latest \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REFNAME=$(version) \
		--build-arg REPOSITORY=$(REPOSITORY) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg PY_VERSION=$(version) \
		-t $(image):latest \
		-t $(image):$(version) \
		-f Dockerfile \
		.

.PHONY: clean-branch
clean-branch: BRANCH := 3.9
clean-branch: image := $(REGISTRY)/$(name)-$(BRANCH)
clean-branch:
	@$(DC) rmi -f \
		$$($(DC) images --filter=reference="$(image)" --format="{{.ID}}") \
		2>/dev/null \
		|| echo "No image found matching \"$(image)\""

.PHONY: clean
clean:
	@for branch in $(branches) ; do $(MAKE) clean-branch BRANCH=$$branch ; done

.PHONY: push-branch
push-branch: BRANCH := 3.9
push-branch: image := $(REGISTRY)/$(name)-$(BRANCH)
push-branch:
	@$(DC) push -a $(image)

.PHONY: push
push:
	@for branch in $(branches) ; do $(MAKE) push-branch BRANCH=$$branch ; done
