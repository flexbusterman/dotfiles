#/bin/sh
# arbtt-capture -r 10 &
xrdb -load ~/.Xresources &
setbg &			# set the background with the `setbg` script
picom --no-fading-openclose &
unclutter &		# Remove mouse when idle
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.7
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" +0.4
xmodmap ~/.Xmodmap
xcape -e 'Mode_switch=Escape'
udiskie -ta &
xset r rate 300 50
xinput disable "Synaptics TM3288-011"
mailsync &
dropbox &
exec awesome
