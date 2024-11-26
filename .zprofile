#
# ~/.zprofile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

#  _   _                  _                 _
# | | | |_   _ _ __  _ __| | __ _ _ __   __| |
# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
# |  _  | |_| | |_) | |  | | (_| | | | | (_| |
# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
#        |___/|_|

# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
# 	exec sway
# fi

# if [ -z "$XDG_RUNTIME_DIR" ]; then
# 	XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
# 	mkdir -pm 0700 "$XDG_RUNTIME_DIR"
# 	export XDG_RUNTIME_DIR
# fi
