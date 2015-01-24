# Lara Maia <lara@craft.net.br> 2015

PROJECT = Entelechy
DESTDIR = build/
REALDESTDIR = $(realpath $(DESTDIR))

CC = cc
CFLAGS = -O3 -lcurl -pedantic-errors -Wall -std=c99
OBJ = scripts/conky/test_network.o
EXECUTABLE = scripts/conky/test_network

checkdest:
	mkdir -p $(DESTDIR)

$(EXECUTABLE): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

install: index-install metacity-install cinnamon-install conky-install

index-install: checkdest
	install -dm755 $(REALDESTDIR)/$(PROJECT)/
	install -Dm644 scripts/index.theme $(REALDESTDIR)/$(PROJECT)/index.theme

metacity-install: checkdest index-install
	install -dm755 $(REALDESTDIR)/$(PROJECT)/metacity-1/
	install -Dm644 images/metacity/* $(REALDESTDIR)/$(PROJECT)/metacity-1/
	install -Dm644 scripts/metacity/metacity.xml $(REALDESTDIR)/$(PROJECT)/metacity-1/metacity-theme-1.xml

cinnamon-install: checkdest index-install
	install -dm755 $(REALDESTDIR)/$(PROJECT)/cinnamon/
	install -Dm644 images/cinnamon/* $(REALDESTDIR)/$(PROJECT)/cinnamon/
	install -Dm644 scripts/cinnamon/cinnamon.css $(REALDESTDIR)/$(PROJECT)/cinnamon/

conky-install: checkdest $(EXECUTABLE)
	install -dm755 $(REALDESTDIR)/$(PROJECT)/conky/
	install -Dm644 scripts/conky/bargraph.lua $(REALDESTDIR)/$(PROJECT)/conky/
	install -Dm644 scripts/conky/conky.theme $(REALDESTDIR)/$(PROJECT)/conky/
	install -Dm755 scripts/conky/test_network $(REALDESTDIR)/$(PROJECT)/conky/
	sed -i "s|bargraph|$(REALDESTDIR)/$(PROJECT)/conky/bargraph|" $(REALDESTDIR)/$(PROJECT)/conky/conky.theme
	sed -i "s|/usr/bin/|$(REALDESTDIR)/$(PROJECT)/conky/|" $(REALDESTDIR)/$(PROJECT)/conky/conky.theme
	sed -i "s|test_network|$(REALDESTDIR)/$(PROJECT)/conky/test_network|" $(REALDESTDIR)/$(PROJECT)/conky/bargraph.lua

clean:
	@rm $(OBJ) $(EXECUTABLE)

# Always rebuild, for now
.PHONY: clean install $(EXECUTABLE)
