PREFIX ?= /usr
SYSCONFDIR ?= /etc
TRASHDIR ?= /tmp
all:
	@echo Run \'make install\' to install del script.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p del.sh $(DESTDIR)$(PREFIX)/bin/del
	@chmod +x $(DESTDIR)$(PREFIX)/bin/del
	@mkdir -p $(DESTDIR)$(SYSCONFDIR)/del
	@cp -pn def_config $(DESTDIR)$(SYSCONFDIR)/del/config
	@mkdir -p $(DESTDIR)$(TRASHDIR)/trash
	@chmod 777 $(DESTDIR)$(TRASHDIR)/trash

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/del
	@rm -rf $(DESTDIR)$(SYSCONFDIR)
	@echo del script succesfully uninstalled!
