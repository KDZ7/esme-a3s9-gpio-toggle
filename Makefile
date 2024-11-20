# Variables pour pkg-config
CFLAGS += $(shell pkg-config --cflags libgpiod)
LDLIBS += $(shell pkg-config --libs libgpiod)

INSTALL_DIR ?= "$(PWD)/_install"

# Nom de l'exécutable
PROG := gpiod

# Liste des fichiers sources
SRC := $(wildcard *.c)
# Liste des fichiers objets
OBJS := $(SRC:.c=.o)

all: $(PROG)

$(PROG): $(OBJS)

install: $(PROG)
	install -m 0755 -d $(INSTALL_DIR)/usr/bin
	install -m 0755 $(PROG) $(INSTALL_DIR)/usr/bin
	install -m 0755 -d $(INSTALL_DIR)/etc/init.d
	install -m 0755 esme-led $(INSTALL_DIR)/etc/init.d

clean:
	-$(RM) -rf $(OBJS) $(PROG)
