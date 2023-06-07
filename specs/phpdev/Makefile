#!/usr/bin/env make

SHELL = /usr/bin/env sh

comma := ,

MAKE_FLAGS=-e --no-print-directory

DOCKER = /usr/bin/env docker
BASE_IMAGE = library/php
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

# Get the digest for a given image
define get_digest
$(shell \
	AUTH_DOCKER_URL="https://auth.docker.io/token?service=registry.docker.io&scope=repository:$(BASE_IMAGE):pull"; \
	MANIFEST_URL="https://registry-1.docker.io/v2/$(BASE_IMAGE)/manifests/$(1)"; \
	TOKEN=$$(curl -s $${AUTH_DOCKER_URL} | jq -r .token); \
	curl -s \
		-H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
		-H "Authorization: Bearer $${TOKEN}" \
		$${MANIFEST_URL} | jq -r .config.digest \
)
endef

# Get the current git revision
git_rev := $(shell git rev-parse --short HEAD)

.PHONY: all
all: $(php_versions)

.PHONY: $(php_versions)
$(php_versions): version = $@
$(php_versions): image = $(IMAGE_REPOSITORY):$(version)
$(php_versions):
	@echo "Building $(IMAGE_REPOSITORY):$(version) ..."
	$(DOCKER) buildx build --load --pull \
		$(if $(CI),--cache-from=type=gha$(comma)scope=$(version)-$(GITHUB_REF_NAME),) \
		$(if $(CI),--cache-to=type=gha$(comma)mode=max$(comma)scope=$(version)-$(GITHUB_REF_NAME),) \
		--cache-from=type=registry,ref=$(image) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--build-arg BASE_IMAGE=$(BASE_IMAGE):$(version)-cli-alpine \
		--build-arg BASE_DIGEST=$(call get_digest,$(version)-cli-alpine) \
		--build-arg CREATED_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg REPOSITORY=$(IMAGE_REPOSITORY) \
		--build-arg REVISION=$(git_rev) \
		--build-arg URL=$(CODE_REPOSITORY)/blob/$(git_rev)/specs/phpdev \
		--build-arg PHP_MINOR_VERSION=$(version) \
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

# Put includes at the end to avoid colision with targets, notably `all` default
include ../../make/env.mk
