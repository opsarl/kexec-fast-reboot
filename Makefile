PREFIX?=/usr/local
DESTDIR?=
INSTALL?=install

TARGET="fast-reboot"

.PHONY: all
all:
        @echo "Nothing to build, it is all bash :)"
        @echo "Try make install"

.PHONY: install
install:
        $(INSTALL) -d $(DESTDIR)$(PREFIX)/bin/
        $(INSTALL) -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/bin

.PHONY: uninstall
uninstall:
        rm -f $(DESTDIR)$(PREFIX)/bin/$(TARGET)
