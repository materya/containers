#!/usr/bin/env make

SHELL = /usr/bin/env sh

include ../../make/env.mk

MAKE_FLAGS=-e --no-print-directory

DOCKER = /usr/bin/env docker
IMAGE_REPOSITORY = $(REGISTRY)/$(ORG)/phpdev

php_xdebug_versions := \
	7.1=2.9.8 \
	7.2=3.1.6 \
	7.3=3.1.6 \
	7.4=3.1.6 \
	8.0=3.2.1 \
	8.1=3.2.1

php_versions := $(foreach ver,$(php_xdebug_versions),$(firstword $(subst =, ,$(ver))))

# Get the xdebug version for a given php version
define get_xdebug_version
$(word 2,$(subst =, ,$(filter $(1)=%,$(php_xdebug_versions))))
endef

# Get the current git revision
git_rev := $(shell git rev-parse --short HEAD)

.PHONY: all
all: $(php_versions)

.PHONY: $(php_versions)
$(php_versions): version = $@
$(php_versions): base_image = php:$(version)-cli-alpine
$(php_versions): image = $(IMAGE_REPOSITORY):$(version)
$(php_versions):
	@$(DOCKER) pull $(base_image)
	@echo "Building $(IMAGE_REPOSITORY):$(version) ..."
	$(DOCKER) build --pull \
		--cache-from $(IMAGE_REPOSITORY):$(version) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--build-arg BASE_IMAGE=$(base_image) \
		--build-arg BASE_DIGEST=$(shell $(DOCKER) inspect --format='{{.RepoDigests}}' $(base_image) | tr -d '[]') \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REPOSITORY=$(IMAGE_REPOSITORY) \
		--build-arg REVISION=$(git_rev) \
		--build-arg URL=$(CODE_REPOSITORY)/blob/$(git_rev)/specs/phpdev \
		--build-arg PHP_VERSION=$(version) \
		--build-arg XDEBUG_VERSION=$(call get_xdebug_version,$(version)) \
		-t $(IMAGE_REPOSITORY):$(version) \
		$(if $(filter $(version),$(lastword $(php_versions))),-t $(IMAGE_REPOSITORY):latest,) \
		-f Dockerfile \
		.

.PHONY: clean-version
clean-version: VERSION := $(lastword $(php_versions))
clean-version: image := $(IMAGE_REPOSITORY):$(VERSION)
clean-version:
	@$(DOCKER) rmi -f \
		$$($(DOCKER) images --filter=reference="$(image)" --format="{{.ID}}") \
		2>/dev/null \
		|| echo "No image found matching \"$(image)\""

.PHONY: clean
clean:
	@for version in $(php_versions) ; \
		do $(MAKE) $(MAKE_FLAGS) clean-version VERSION=$$version ; \
	done

.PHONY: push-version
push-version: VERSION := $(lastword $(php_versions))
push-version: image := $(IMAGE_REPOSITORY):$(VERSION)
push-version:
	@$(DOCKER) push $(image)

.PHONY: push
push:
	@$(DOCKER) push -a $(IMAGE_REPOSITORY)
