#!/bin/bash

declare PROJECTNAME="Entelechy"
declare INSTALLPREFIX="$HOME/.themes"

test -z "$1" || INSTALLPREFIX="$1"

function create_desktop_entry() {
cat << EOF > "$1"
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=Entelechy
Comment=A Perfect beautiful theme
Encoding=UTF-8

[X-GNOME-Metatheme]
GtkTheme=Entelechy
MetacityTheme=Entelechy
IconTheme=default
CursorTheme=default
EOF
}

install -dm755 "$INSTALLPREFIX/$PROJECTNAME"/{cinnamon/,gtk-2.0/,gtk-3.0/,metacity-1/}/
install -Dm644 images/cinnamon/* "$INSTALLPREFIX/$PROJECTNAME/cinnamon/"
install -Dm644 images/metacity/* "$INSTALLPREFIX/$PROJECTNAME/metacity-1/"
install -Dm644 cinnamon.css "$INSTALLPREFIX/$PROJECTNAME/cinnamon/"
install -Dm644 metacity.xml "$INSTALLPREFIX/$PROJECTNAME/metacity-1/metacity-theme-1.xml"
create_desktop_entry "$INSTALLPREFIX/$PROJECTNAME/index.theme"

