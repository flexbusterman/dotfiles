[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/.local/bin/statusbar ]] && export PATH=$HOME/.local/bin/statusbar:$PATH
# [[ -d $HOME/.config/emacs/bin/ ]] && export PATH=$HOME/.config/emacs/bin:$PATH

export ZSHENV_RAN=true

# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666f98"
# export QT_QPA_PLATFORMTHEME="qt6ct"
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=Fusion
# export QT_QPA_PLATFORMTHEME="xcb"
export BROWSER=qutebrowser
export EDITOR="nvim"
export HEADPHONES='50:5E:5C:F1:73:B1'
export MANPAGER="nvim +Man!"
export MPD_HOST="$XDG_RUNTIME_DIR/mpd/socket"
export SHELL=/usr/bin/zsh
export TERMINAL=kitty
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export __NV_PRIME_RENDER_OFFLOAD=1
export DEBUG_CODEIUM="warn"
export WEBKIT_DISABLE_DMABUF_RENDERER=1.
export TIMEWARRIORDB="~/TASK/timewarrior/"
export SYSTEMD_EDITOR=nvim
export XKB_DEFAULT_OPTIONS=caps:escape
export WALLPAPER=~/.local/share/$USER/background.jpg
export XDG_CURRENT_DESKTOP=Unity
export TASKRC=~/.config/taskwarrior/taskrc

export XSECURELOCK_SAVER=saver_xscreensaver
# Specifies the time (in seconds) to wait for response to a prompt by `auth_x11` before giving up and reverting to the screen saver.
export XSECURELOCK_AUTH_TIMEOUT=2
# Specifies the time (in seconds) before telling X11 to fully blank the screen; a negative value disables X11 blanking.
export XSECURELOCK_BLANK_TIMEOUT=1800
# Specifies which DPMS state to put the screen in when blanking (one of standby, suspend, off and on, where "on" means to not invoke DPMS at all).
export XSECURELOCK_BLANK_DPMS_STATE="off"
# If set to 0, the key pressed to stop the screen saver and spawn the auth child is sent to the auth child (and thus becomes part of the password entry).
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
