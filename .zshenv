[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/.local/bin/statusbar ]] && export PATH=$HOME/.local/bin/statusbar:$PATH
[[ -d $HOME/.config/emacs/bin/ ]] && export PATH=$HOME/.config/emacs/bin:$PATH
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666f98"
# export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_QPA_PLATFORMTHEME="xcb"
export BROWSER=qutebrowser
export EDITOR="nvim"
export HEADPHONES='3C:B0:ED:BD:8B:3F'
export MANPAGER="nvim +Man!"
export MPD_HOST=/run/user/1000/mpd/socket
export SHELL=/usr/bin/zsh
export TERMINAL=kitty
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export __NV_PRIME_RENDER_OFFLOAD=1
export DEBUG_CODEIUM="warn"
export WEBKIT_DISABLE_DMABUF_RENDERER=1.
# export TASKRC=~/.config/taskwarrior/taskrc

# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export PATH=$PATH:$HOME/.local/bin/
# export PATH=$PATH:$HOME/.cargo/bin/
# export PATH=$PATH:$HOME/.local/bin/statusbar/

export TIMEWARRIORDB="~/TASK/timewarrior/"

export SYSTEMD_EDITOR=nvim

# export NEXTCLOUD_PHP_CONFIG=/etc/webapps/nextcloud/php.ini

# export SWAYSOCK=$( lsof /run/user/1000/sway-ipc.* 2>/dev/null | awk '{print $9}' | tail -n +2 | sort | uniq )
