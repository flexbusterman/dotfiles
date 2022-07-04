#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
wait
pgrep polybar || polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

# autohide if focus variable is set
# (xdo id -m -N Polybar && )

# focus=$(cat ~/.config/leftwm/focus | while read line; do echo $line; done)

# if [[ $focus == "true" ]]; then
	# (xdo id -m -N Polybar && polybar-msg cmd hide)
# else
	# wait
	# (xdo id -m -N Polybar && polybar-msg cmd show)
# fi
