#!/usr/bin/env make

root := $(patsubst %/make/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ENVFILE = .env
ABS_ENVFILE = $(root)/$(ENVFILE)

sinclude $(ABS_ENVFILE)
export $(shell [ -f $(root)/$(ABS_ENVFILE) ] && sed 's/=.*//' $(ABS_ENVFILE))

#==============================================================================
# TARGETS
#==============================================================================

$(ENVFILE) $(ABS_ENVFILE):
	cp $(ABS_ENVFILE).defaults $(ABS_ENVFILE)
