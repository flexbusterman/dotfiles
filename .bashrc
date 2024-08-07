#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd

# history
# shopt -s histappend
# export HISTCONTROL=ignoredups:erasedups
export HISTCONTROL=erasedups
# unlimited history
export HISTFILESIZE=
export HISTSIZE=

# environment variables
export TERMINAL=st
export EDITOR=nvim
export BROWSER=qutebrowser
export SHELL=/bin/bash
export MANPAGER="nvim +Man!"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
# export ANDROID_HOME=$HOME/Android/Sdk
# export ANDROID_SDK_ROOT=$HOME/Android/Sdk
# export ANDROID_SDK_HOME=$HOME/Android/Sdk
# export ANDROID_AVD_HOME=$HOME/.config/.android/avd
# export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export HEADPHONES='50:C2:75:29:C7:6E'
export MPD_PORT=49152
export MPD_HOST="/home/flex/.mpd/socket"
export RANGER_LOAD_DEFAULT_RC=FALSE

export __NV_PRIME_RENDER_OFFLOAD=1

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.local/bin/statusbar/

if [ -f ~/.envPrivate ]; then
    source ~/.envPrivate
fi

#PS1='\u@\h \W \$ '
# standard colors
R='\[\e[38;2;255;100;100m\]'
G='\[\e[38;2;100;255;100m\]'
B='\[\e[38;2;100;100;255m\]'
W='\[\e[0m\]'
PS1="$R\u$W@$B\h$W:$G\w$W \$ "

alias ls='ls --color=auto'

alias la="exa -la --group-directories-first"
alias less="bat --theme=Dracula"
alias lg="exa -la | grep --color=always -i"
alias lm="exa -la --sort=modified"
alias ls="exa"
alias lt="exa -lar --sort=size"
alias rf='rm -rf'
alias grep='grep --color=auto'
alias vn="cd /home/flex/.config/nvim/; nvim init.lua"
alias vb="cd /home/flex/; nvim .bashrc"
alias c="cd /home/flex/.config/"
alias vr="cd ~/Dropbox/ORGMODE/; nvim refile.org"
alias q=exit
alias pg="ping google.com"

# navigation
alias d='cd ~/Dropbox/'
alias D='cd ~/Downloads/'
alias c='cd ~/.config/'
alias b='cd ~/.local/bin/'
alias m='cd /run/media/$USER/'
alias g='cd ~/.local/src/'
alias f='cd ~/.flarbs/'
alias o='cd ~/Dropbox/ORGMODE/'

# save current dir in workdir file
alias sw='echo $PWD > ~/.workdir'
alias cw='cd "$(cat ~/.workdir)"'
alias vw='cd "$(cat ~/.workdir)"; nvim -c "NvimTreeToggle"'

# git
alias dot="/usr/bin/git --git-dir=$HOME/.dot.git/ --work-tree=$HOME"
alias pdot="/usr/bin/env git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME"

# network shortcuts
alias wls="nmcli device wifi"

# ssh add function
sa() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$*
}

dp() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="$*"
  dot add -u
  dot commit -m "$result"
  dot push
}

pdp() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="$*"
  pdot add -u
  pdot commit -m "$result"
  pdot push
}

pass() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/digitalocean
	command pass $*
}

ssh() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/digitalocean
	command ssh $*
}

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
