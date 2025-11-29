#
# ~/.bash_profile
#

BASH_PROFILE_RAN=true

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -d $HOME/.local/bin ]] && PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/.local/bin/statusbar ]] && PATH=$HOME/.local/bin/statusbar:$PATH
[[ -d $HOME/.config/emacs/bin/ ]] && PATH=$HOME/.config/emacs/bin:$PATH

QT_QPA_PLATFORMTHEME="qt5ct"
BROWSER=qutebrowser
EDITOR="nvim"
HEADPHONES='3C:B0:ED:BD:8B:3F'
MANPAGER="nvim +Man!"
MPD_HOST=/run/user/1000/mpd/socket
QT_QPA_PLATFORMTHEME=qt6ct
RANGER_LOAD_DEFAULT_RC=FALSE
SHELL=/usr/bin/zsh
TERMINAL=kitty
XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
__NV_PRIME_RENDER_OFFLOAD=1
DEBUG_CODEIUM="warn"
XKB_DEFAULT_OPTIONS=caps:escape
TASKRC=~/.config/taskwarrior/taskrc
WALLPAPER=~/.local/share/$USER/background.jpg

TIMEWARRIORDB="~/TASK/timewarrior/"
SYSTEMD_EDITOR=nvim
