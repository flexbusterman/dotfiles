#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
(xdo id -m -N Polybar && polybar-msg cmd hide)&
echo "Polybar launched..."
