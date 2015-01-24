# Lara Maia <lara@craft.net.br> 2015

PROJECT = Entelechy
DESTDIR = build/
THEMEDIR = .themes/
ICONDIR = .icon/
REALDESTDIR = $(realpath $(DESTDIR))
TIMESTAMP = `date '+%Y%m%d'`

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
	install -dm755 $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/
	install -Dm644 scripts/index.theme $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/index.theme

metacity-install: checkdest index-install
	install -dm755 $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/metacity-1/
	install -Dm644 images/metacity/* $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/metacity-1/
	install -Dm644 scripts/metacity/metacity.xml $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/metacity-1/metacity-theme-1.xml

cinnamon-install: checkdest index-install
	install -dm755 $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/cinnamon/
	install -Dm644 images/cinnamon/* $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/cinnamon/
	install -Dm644 scripts/cinnamon/cinnamon.css $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/cinnamon/

conky-install: checkdest $(EXECUTABLE)
	install -dm755 $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	install -Dm644 scripts/conky/bargraph.lua $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	install -Dm644 scripts/conky/conky.theme $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	install -Dm755 scripts/conky/test_network $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	sed -i "s|bargraph|$(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/bargraph|" $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/conky.theme
	sed -i "s|/usr/bin/|$(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/|" $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/conky.theme
	sed -i "s|test_network|$(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/test_network|" $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/bargraph.lua

clean:
	@rm -f $(OBJ) $(EXECUTABLE)
	@rm -f *.zip

zip: install
	7z a Entelechy-\(Conky\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	7z a Entelechy-\(Metacity\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{metacity-1/,index.theme}
	7z a Entelechy-\(Cinnamon\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{cinnamon/,index.theme}
	7z a Entelechy-\(ALL\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{cinnamon,metacity-1,conky,index.theme}


# Always rebuild, for now
.PHONY: clean install $(EXECUTABLE)
