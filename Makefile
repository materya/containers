#!make
SHELL = /bin/sh

%: | specs/%
	@$(MAKE) -C specs/$@

specs/%:
	@echo "No spec found for container \"$*\"." && false
