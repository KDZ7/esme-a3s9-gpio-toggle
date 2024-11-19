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
	$(CC) -o $(PROG) $(OBJS) $(LDLIBS)

install: $(PROG)
	install -m 0755 -d $(INSTALL_DIR)/usr/bin
	install -m 0755 $(PROG) $(INSTALL_DIR)/usr/bin
clean:
	-$(RM) -rf $(OBJS) $(PROG)
