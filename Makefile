all:
	@echo 'Nothing to build, use `make PREFIX=... install`'

INSTALL_FILE    = install -p -m 644
INSTALL_PROGRAM = install -p -m 755

prefix_is_defined:
ifeq ($(strip $(PREFIX)),)
	$(error PREFIX is not set)
endif

install: prefix_is_defined
	$(info Installing in $(PREFIX))
	mkdir -p $(PREFIX)/bin
	$(INSTALL_FILE) COPYING $(PREFIX)
	$(INSTALL_FILE) README.md $(PREFIX)
	$(INSTALL_FILE) TODO.md $(PREFIX)
	$(INSTALL_PROGRAM) get-versions $(PREFIX)/bin
