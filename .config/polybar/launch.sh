#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# wait
# pgrep polybar || polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

# autohide if focus variable is set
# (xdo id -m -N Polybar && )

focus=$(cat ~/.config/i3/focus | while read line; do echo $line; done)
bar=$(cat ~/.config/i3/bar | while read line; do echo $line; done)
notify-send "focus: $focus"
notify-send "bar: $bar"

if [[ $focus == "true" || $bar == "false" ]]; then
	wait
	(xdo id -m -N Polybar && polybar-msg cmd hide)
else
	wait
	(xdo id -m -N Polybar && polybar-msg cmd show)
fi
