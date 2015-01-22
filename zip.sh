#!/bin/sh
THEME_ROOT="$HOME"/.themes/Entelechy

7z a Entelechy-\(Conky\)-`date '+%Y%m%d'`.zip "$THEME_ROOT/conky/"
7z a Entelechy-\(Metacity\)-`date '+%Y%m%d'`.zip "$THEME_ROOT"/{metacity-1/,index.theme}
7z a Entelechy-\(Cinnamon\)-`date '+%Y%m%d'`.zip "$THEME_ROOT"/{cinnamon/,index.theme}
7z a Entelechy-\(Gtk\)-`date '+%Y%m%d'`.zip "$THEME_ROOT"/{gtk-{2.0,3.0}/,index.theme}
7z a Entelechy-\(ALL\)-`date '+%Y%m%d'`.zip "$THEME_ROOT"/{gtk-{2.0,3.0}/,cinnamon,metacity-1,conky,index.theme}
