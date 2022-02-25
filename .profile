#/bin/sh
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH="${PATH}:/home/flex/.local/bin"
export PATH="${PATH}:/home/flex/.local/bin/statusbar"
export SYSTEMD_EDITOR=vim
# arbtt-capture -r 10 &
# xrdb -load ~/.Xresources &
setbg &			# set the background with the `setbg` script
picom --no-fading-openclose &
unclutter &		# Remove mouse when idle
# xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.7
# xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" +0.4
xmodmap ~/.Xmodmap
udiskie -ta &
xset r rate 300 50 &
# xinput disable "Synaptics TM3288-011"
# mailsync &
dropbox &
dunst &
dwmblocks &
xcape -e 'Mode_switch=Escape' &
# exec dwm
