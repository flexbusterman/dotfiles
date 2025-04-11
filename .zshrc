# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select

# tab autocompletions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
setopt autocd   # Automatically cd into typed directory.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.

# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

bindkey '^ ' autosuggest-execute

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# trims leading whitespace on first line and trailing whitespace and newlines on last line
# function pastefunction {
# 	# xclip -o -sel clip | sed "1s/^[ \t]*//" | sed "$s/[ \t\n]*$//"
# 	printf %s "$(xclip -o -sel clip | sed "1s/^[ \t]*//")"
# }
#
# zle -N pastefunction
#
# bindkey -a p pastefunction

[ -f ~/.envPrivate ] && source ~/.envPrivate

# aliases
alias ls='exa --group-directories-first'
alias la="exa -la --group-directories-first"
alias less="bat --theme=Dracula"
alias lg="exa -la | grep --color=always -i"
alias lm="exa -la --sort=modified"
alias ls="exa"
alias lt="exa -lar --sort=size"
alias rf='rm -rf'
alias grep='grep --color=auto'
alias q=exit
alias pg="ping google.com"
# alias nvim="~/.local/bin/nvimopen"

# nvim edit shortcuts
alias vb="cd ~; nvim .bashrc"
alias ve="cd ~/.local/bin/; nvim editfile"
alias vf="cd ~/.local/src/flarbs/; nvim flarbsinstall"
# alias vH="cd ~/.config/hypr/; nvim hyprland.conf"
alias vh="cd ~/.history/zsh/; nvim history"
alias vk="cd ~/.config/kitty/; nvim kitty.conf"
alias vn="cd ~/.config/nvim/; nvim init.lua"
alias vo="cd ~/.local/bin/; nvim openfile"
alias vp="cd ~/.config/picom/; nvim picom.conf"
alias vq="cd ~/.config/qutebrowser/; nvim autoconfig.yml"
alias vr="cd ~/ORGMODE/; nvim refile.org"
alias vs="cd ~/.config/sxhkd/; nvim sxhkdrc"
alias vt="cd ~/; nvim .tmux.conf"
alias vx="cd ~; nvim .xinitrc"
alias vy="cd ~/.config/yazi/; nvim yazi.toml"
alias vz="cd ~; nvim .zshrc"
alias vi="cd ~/.config/i3/; nvim config"
alias vw="cd ~/.config/waybar/; nvim config.jsonc"
alias vl="cd ~/.config/layman/; nvim config.toml"
alias vd="cd ~/.local/src/dwm/; nvim config.def.h"

# emacs edit shortcuts
alias e="emacsclient -c"
alias eb="cd ~; emacsclient -c .bashrc"
alias ee="cd ~/.local/bin/; emacsclient -c editfile"
alias ef="cd ~/.local/src/flarbs/; emacsclient -c flarbsinstall"
alias eh="cd ~/.history/zsh/; emacsclient -c history"
alias ek="cd ~/.config/kitty/; emacsclient -c kitty.conf"
alias en="cd ~/.config/emacsclient -c/; nvim init.lua"
alias eo="cd ~/.local/bin/; emacsclient -c openfile"
alias ep="cd ~/.config/picom/; emacsclient -c picom.conf"
alias eq="cd ~/.config/qutebrowser/; emacsclient -c autoconfig.yml"
alias er="cd ~/ORGMODE/; emacsclient -c refile.org"
alias es="cd ~/.config/sxhkd/; emacsclient -c sxhkdrc"
alias et="cd ~/; emacsclient -c .tmux.conf"
alias ex="cd ~; emacsclient -c .xinitrc"
alias ey="cd ~/.config/yazi/; emacsclient -c yazi.toml"
alias ez="cd ~; emacsclient -c .zshrc"
alias ei="cd ~/.config/i3/; emacsclient -c config"
alias ew="cd ~/.config/waybar/; emacsclient -c config.jsonc"
alias el="cd ~/.config/layman/; emacsclient -c config.toml"
alias ed="cd ~/.local/src/dwm/; emacsclient -c config.def.h"

# script shortcuts
alias fn="fzfnotes"

alias copy="xclip -sel clip"

# navigation
alias d='cd ~/Dropbox/'
alias D='cd ~/Downloads/'
alias C='cd ~/.config/'
alias b='cd ~/.local/bin/'
alias m='cd /run/media/$USER/'
alias g='cd ~/.local/src/'
alias f='cd ~/.flarbs/'
alias o='cd ~/Dropbox/ORGMODE/'
alias v='cd ~/Downloads/VIDEO/'
alias s="cd ~/Dropbox/$(date +%Y)\ FOTO/SCREENSHOTS/"
alias a="cd ~/Documents/"

# taskwarrior
alias t="task"

# save current dir in workdir file
alias sw='echo $PWD > ~/.workdir'
alias cw='cd "$(cat ~/.workdir)"'
alias vw='cd "$(cat ~/.workdir)"; nvim -c "NvimTreeToggle"'

# git
alias dot="/usr/bin/git --git-dir=$HOME/.dot.git/ --work-tree=$HOME"
alias pdot="/usr/bin/git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME"

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

gp() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="$*"
  git add -u
  git commit -m "$result"
  git push
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
# if [[ -n $DISPLAY ]]; then
#   copy_line_to_x_clipboard () {
#     printf %s "$READLINE_LINE" | xsel -ib
#   }
#   bind -x '"\eW": copy_line_to_x_clipboard'
# fi
}

# Command to open man files in emacs
# man() {
#     emacsclient -nw -e '(man "'"$1"'")'
# }

# history
HISTSIZE=10000000
SAVEHIST=10000000
export HISTFILE="$HOME/.history/zsh/history"
setopt hist_ignore_dups     # do not record an event that was just recorded again
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_space    # do not record an event starting with a space
setopt hist_save_no_dups    # do not write a duplicate event to the history file
setopt inc_append_history   # write to the history file immediately, not when the shell exits
setopt share_history        # share history between terminals

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# PS1="%B%{$fg[blue]%}>%{$reset_color%}%b "

# change word selection to exclude slashes
autoload -U select-word-style
select-word-style bash

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || sudo git clone "https://github.com/zsh-users/zsh-syntax-highlighting" /usr/share/zsh/plugins/zsh-syntax-highlighting/
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt vi
KEYTIMEOUT=1
# change cursor shape in vi mode
zle-keymap-select () {
if [[ $KEYMAP == vicmd ]]; then
	# the command mode for vi
	echo -ne "\e[2 q"
else
	# the insert mode for vi
	echo -ne "\e[5 q"
fi
}

# fzf in terminal, fzf must be installed to use this
eval "$(fzf --zsh)"

clear
