# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd   # Automatically cd into typed directory.
stty stop undef   # Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
      echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
      [[ ${KEYMAP} == viins ]] ||
      [[ ${KEYMAP} = '' ]] ||
      [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp" >/dev/null
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -l\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# _____ _
# |  ___| | _____  __
# | |_  | |/ _ \ \/ /
# |  _| | |  __/>  <
# |_|   |_|\___/_/\_\

alias vim="nvim"
alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias dls="maestral ls | sort -k 3,3 | less -p included"
alias drm="maestral excluded add"
alias dadd="maestral excluded remove"
alias ds='maestral status'
alias dr='maestral restart'
alias cheat='tldr'
# alias la="exa -la"
# alias ls="exa"
alias reaper="/home/flex/opt/REAPER/reaper"
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias copy='xclip -sel clip'
alias rf='rm -rf'

test () {
  result="\"$*\""
  echo $result
}

in () {
  # sudo apt -y install $*
  sudo pacman -S --noconfirm $*
}

un () {
  # sudo apt -y remove $*
  sudo pacman -Rns $*
}

# prepend date
pd () {
  date=$(date +%F)
  mv "$*" "$date $*"
}

gp () {
  result="\"$*\""
  git add .
  git commit -m $result
  git push
}

dp () {
  result="\"$*\""
  dot add -u
  dot commit -m $result
  dot push
}

dev () {
  st -e zsh -c "cd ~/GIT/kalle2019; fish -c \"npm run dev\"" &
  st -e zsh -c "nvim ~/Documents/buffalobillgates.js -c \"CocDisable\"" &
  st -e zsh -c "cd ~/GIT/kalle2019; nvim -c \"NERDTree\"" &
}

# start google chrome with argument as address
# c () {
# set result (string join ' ' $*)
# nohup google-chrome http://$result  >> /dev/null > exhibitor.out 2>&1 & && disown (jobs -p)
# i3-msg workspace 2
# }

# timer () {
# set count $*
# for n in (seq $count -1 0)
# clear
# set minutes (math -s0 "$n / 60")
# set seconds (math -s0 "$n % 60")
# if test $seconds -lt 10
# echo $minutes:0$seconds
# else
# echo $minutes:$seconds
# }
# sleep 1
# }
# clear
# figlet "Done"
# }

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
ssh-add ~/.ssh/bitbucket
clear

# Load syntax highlighting; should be last according to Luke.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
