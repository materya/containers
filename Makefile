#!/usr/bin/env make

SHELL = /usr/bin/env sh

include make/env.mk

%: | .env specs/%
	@$(MAKE) -C specs/$@

specs/%:
	$(error No spec found for container "$*")
