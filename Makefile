#!make
SHELL = /bin/sh

%:
	@$(MAKE) -C specs/$@ \
	2>/dev/null \
	|| echo "No spec found for container \"$@\"."
