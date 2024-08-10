#!/bin/bash
# xrdb ~/.Xresources
feh --bg-fill ~/.local/share/flex/background.jpg
# remaps &
# xset fp+ /usr/share/fonts/TTF/FiraMono-Medium.ttf
# picom --no-fading-openclose -o 0 &
unclutter --timeout 1 &
udiskie -ta &
# xss-lock -- sh -c "sleep 0.2; /home/$USER/.local/bin/slockunmute" &
# mailsync &
dropbox &
dunst &
# mpd &
# qpwgraph -m &
# pidof dwmblocks || dwmblocks &
# srandrd displayhandler &
# blueberry-tray &
syncthing &
syncthingtray &
# xdotool mousemove $(xdotool getdisplaygeometry | awk '{print $1-1, $2-1}') &
tmux new-session -d -s main &
sxhkd &
# rfkill unblock bluetooth &
# exec dwmstart
export DESKTOP_SESSION=plasma
exec startplasma-x11
