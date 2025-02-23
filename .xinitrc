#!/usr/bin/env bash
xrdb ~/.Xresources
feh --bg-fill ~/.local/share/flex/background.jpg
remaps &
# xset fp+ /usr/share/fonts/TTF/FiraMono-Medium.ttf
picom &
unclutter --timeout 1 &
udiskie -ta &
# # xss-lock -- sh -c "sleep 0.2; /home/$USER/.local/bin/slockunmute" &
# # mailsync &
dropbox &
dunst &
# mpd &
# qpwgraph -m &
pidof dwmblocks || dwmblocks &
# # srandrd displayhandler &
blueberry-tray &
# syncthing --no-browser &
# # syncthingtray --wait &
# # dotool mousemove $(xdotool getdisplaygeometry | awk '{print $1-1, $2-1}') &
tmux new-session -d -s main &
# kitty -e tmux attach-session -t main &
sxhkd &
xautolock -time 3 -locker idlescript &
task export >~/.local/share/flex/tasklist.json &
historybackup &
/usr/bin/emacs --daemon &
# # rfkill unblock bluetooth &
exec ~/.local/bin/dwmstart
# # export DESKTOP_SESSION=plasma
# # export KDEWM=~/.local/bin/dwmstart
# exec startplasma-x11
# exec Hyprland
# echo "Hello from login"
