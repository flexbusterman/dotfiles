[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/.local/bin/statusbar ]] && export PATH=$HOME/.local/bin/statusbar:$PATH
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666f98"
export QT_QPA_PLATFORMTHEME="qt5ct"
export BROWSER=qutebrowser
export EDITOR=nvim
export HEADPHONES='2C:BE:EB:D6:A1:5D'
export MANPAGER="nvim +Man!"
# export MPD_HOST="~/.mpd/socket"
# export MPD_PORT=49152
export MPD_HOST=/run/user/1000/mpd/socket
export QT_QPA_PLATFORMTHEME=qt6ct
export RANGER_LOAD_DEFAULT_RC=FALSE
export SHELL=/usr/bin/zsh
export TERMINAL=kitty
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export __NV_PRIME_RENDER_OFFLOAD=1
export DEBUG_CODEIUM="warn"
export XKB_DEFAULT_OPTIONS=caps:escape
export TASKRC=~/.config/taskwarrior/taskrc

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.cargo/bin/
export PATH=$PATH:$HOME/.local/bin/statusbar/

export TIMEWARRIORDB="~/TASK/timewarrior/"

export SYSTEMD_EDITOR=nvim

# export NEXTCLOUD_PHP_CONFIG=/etc/webapps/nextcloud/php.ini

# export SWAYSOCK=$( lsof /run/user/1000/sway-ipc.* 2>/dev/null | awk '{print $9}' | tail -n +2 | sort | uniq )
