#/bin/sh
# arbtt-capture -r 10 &
xrdb -load ~/.Xresources &
setbg &			# set the background with the `setbg` script
picom --no-fading-openclose -o 0 &
unclutter &		# Remove mouse when idle
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.85 &
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" -0.55 &
setxkbmap -option shift:both_capslock_cancel;
xmodmap ~/.Xmodmap 
xcape -e 'Mode_switch=Escape'
udiskie -ta &
xset r rate 300 50 &
xinput disable "Synaptics TM3288-011" &
xinput disable "SynPS/2 Synaptics TouchPad" &
mailsync &
dropbox &
dunst &
qpwgraph -m &
# pidof mpd || mpd &
pidof dwmblocks || dwmblocks &
srandrd displayhandler &
# script that loops to restart dwm
blueberry-tray &
exec startdwm
# exec i3 
# exec bspwm
