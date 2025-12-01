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
xautolock -time 3 -locker idlescript &
~/.local/bin/historybackup &
mpd &
transmission-daemon &
exec ~/.local/bin/dwmstart
# rfkill unblock bluetooth &
