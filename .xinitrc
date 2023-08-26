#/bin/sh
# arbtt-capture -r 10 &
xrdb -load ~/.Xresources &
# wallset -q
# wallset -V ~/Pictures/RANDOM/starfield.mp4 &
setbg &			# set the background with the `setbg` script
xset fp+ /usr/share/fonts/TTF/FiraMono-Medium.ttf
picom --no-fading-openclose -o 0 &
unclutter &		# Remove mouse when idle
setxkbmap -option shift:both_capslock_cancel;
xmodmap ~/.Xmodmap
xcape -e 'Mode_switch=Escape'
udiskie -ta &
xset r rate 300 50 &
# T460
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.45
# xinput disable "Synaptics TM3288-011" &
xinput set-prop "Synaptics TM3288-011" "libinput Accel Speed" 0.3
xinput set-prop "Synaptics TM3288-011" "libinput Tapping Enabled" 1
# T14
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" -0.55
# xinput disable "SynPS/2 Synaptics TouchPad" &
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.3
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xss-lock -- sh -c "sleep 0.2; /home/$USER/.local/bin/slockunmute" &
mailsync &
dropbox &
dunst &
qpwgraph -m &
# pidof mpd || mpd &
pidof dwmblocks || dwmblocks &
srandrd displayhandler &
# script that loops to restart dwm
blueberry-tray &
xdotool mousemove $(xdotool getdisplaygeometry | awk '{print $1-1, $2-1}') &
tmux new-session -d -s main &
exec dwmstart
# exec i3
# exec bspwm
