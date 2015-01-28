# Lara Maia <lara@craft.net.br> 2015

PROJECT = Entelechy
DESTDIR = /usr/share
THEMEDIR = themes
ICONDIR = icons
REALDESTDIR = $(realpath $(DESTDIR))
TIMESTAMP = `date '+%Y%m%d'`

CC = cc
XCURSORGEN = /usr/bin/xcursorgen
CFLAGS = -O3 -lcurl -pedantic-errors -Wall -std=c99
OBJ = scripts/conky/test_network.o
EXECUTABLE = scripts/conky/test_network

all: $(EXECUTABLE)

checkdest:
	mkdir -p $(DESTDIR)

$(EXECUTABLE): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

install: index-install metacity-install cinnamon-install conky-install cursor-install

index-install: checkdest
	install -dm755 $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/
	install -Dm644 scripts/index.theme $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/index.theme

cursor-index-install: checkdest icon-index-install
	install -dm755 $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/
	install -Dm644 scripts/cursor.theme $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursor.theme

icon-index-install: checkdest
	install -dm755 $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/
	install -Dm644 scripts/icon.theme $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/index.theme

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

cursor-install: checkdest cursor-index-install icon-index-install
	install -dm755 $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors
	$(XCURSORGEN) -p images/cursor/normal_select scripts/cursor/normal_select.cursor $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/left_ptr
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/right_ptr
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/arrow
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/top_left_arrow
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/context-menu
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/copy
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/default
	ln -sf left_ptr $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/dotbox
	$(XCURSORGEN) -p images/cursor/normal_select scripts/cursor/link_select.cursor $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/link
	ln -sf link $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/hand
	ln -sf link $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/hand1
	ln -sf link $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/hand2
	ln -sf link $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/alias
	ln -sf link $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/dnd-link
	$(XCURSORGEN) -p images/cursor/text_select scripts/cursor/text_select.cursor $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/xterm
	ln -sf xterm $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/ibeam
	ln -sf xterm $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/text
	ln -sf xterm $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/vertical-text
	$(XCURSORGEN) -p images/cursor/help_select scripts/cursor/help_select.cursor $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/question_arrow
	ln -sf question_arrow $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/help
	ln -sf question_arrow $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/left_ptr_help
	ln -sf question_arrow $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/whats_this
	$(XCURSORGEN) -p images/cursor/busy scripts/cursor/busy.cursor $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/watch
	ln -sf watch $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/left_ptr_watch
	ln -sf watch $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/progress
	ln -sf watch $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/wait
	ln -sf watch $(REALDESTDIR)/$(ICONDIR)/$(PROJECT)/cursors/half-busy

clean:
	rm -f $(OBJ) $(EXECUTABLE)
	rm -f *.zip

distclean:
	rm -rf build/

zip: install
	7z a Entelechy-\(Conky\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/conky/
	7z a Entelechy-\(Metacity\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{metacity-1/,index.theme}
	7z a Entelechy-\(Cinnamon\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{cinnamon/,index.theme}
	7z a Entelechy-\(ALL\)-$(TIMESTAMP).zip $(REALDESTDIR)/$(THEMEDIR)/$(PROJECT)/{cinnamon,metacity-1,conky,index.theme}


# Always rebuild, for now
.PHONY: clean install $(EXECUTABLE)
