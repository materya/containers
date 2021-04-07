#!make
SHELL = /bin/sh

%:
	@$(MAKE) -C specs/$@
