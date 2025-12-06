#!/usr/bin/env bash
xrdb ~/.Xresources
feh --bg-fill /home/flex/.local/share/flex/background-xmas.jpeg
~/.local/bin/remaps &
picom -b &
unclutter --timeout 1 &
udiskie -ta &
dropbox &
dunst &
slstatus &
blueberry-tray &
sxhkd &
~/.local/bin/historybackup &
xss-lock -l -- xsecurelock &
mpd &
transmission-daemon &
exec ~/.local/bin/dwmstart
# rfkill unblock bluetooth &
