# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd   # Automatically cd into typed directory.
stty stop undef   # Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=20000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab c omplete menu:
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
 '^e' edit-command-line

# _____ _
# |  ___| | _____  __
# | |_  | |/ _ \ \/ /
# |  _| | |  __/>  <
# |_|   |_|\___/_/\_\

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

alias vim="nvim"
alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias dls="maestral ls | sort -k 3,3 | less -p included"
alias drm="maestral excluded add"
alias dadd="maestral excluded remove"
alias ds='maestral status'
alias dr='maestral restart'
alias cheat='tldr'
alias la="exa -la"
alias ls="exa"
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias copy='xclip -sel clip'
alias rf='rm -rf'

test () {
  result="\"$*\""
  echo $result
}

uz () {
  for archive in $*;
  #do 7z x -o"`basename \"$archive\"`" "$archive";
  do 7z x -o"${archive%.*}" "$archive";
  done
}

# dex () {
  #for directory in $*
  #echo '$directory'
  ##do maestral exclude add $dir
  #done
#}


yin () {
  yaourt -S $*
}

yun () {
  yaourt -Rs $*
}

yup () {
  yaourt -Syua
}

yf () {
  yaourt -Ss $*
}

yls () {
  yaourt -Q
}

pin () {
  sudo pacman -S --noconfirm $*
}

pun () {
  sudo pacman -Rns $*
}

pup () {
  sudo pacman -Syu
}

pf (){
  pacman -Ss "$*"
}

pls (){
  pacman -Qe
}

pla (){
  pacman -Q
}

pc (){
  pacman -Scc
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

hi () {
  result=$*
  history 0 | grep $result
}

mind () {
  st -e zsh -c "cd ~/GIT/kalle2019; zsh -c \"npm run dev\"" &
  st -e zsh -c "cd ~/GIT/kalle2019;" &
  st -e zsh -c "cd ~/Documents/; nvim -c \"autocmd! CursorHold * CocDisable\" Scandinavian Mind.wiki" &
  # cd ~/GIT/kalle2019/; nvim -c "autocmd! CursorHold * NERDTree"
  cd ~/GIT/mind/; nvim;
}

dev () {
  st -e zsh -c "cd ~/GIT/kalle2019; zsh -c \"npm run dev\"" &
  st -e zsh -c "cd ~/Documents/; nvim -c \"autocmd! CursorHold * CocDisable\" buffalobillgates.js" &
  # cd ~/GIT/kalle2019/; nvim -c "autocmd! CursorHold * NERDTree"
  cd ~/GIT/kalle2019/; nvim;
}

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
ssh-add ~/.ssh/bitbucket
ssh-add ~/.ssh/mind
clear

# Aggressive autocomplete
#autoload predict-on
#predict-on


# append a trailing ‘/’ to all directory names resulting from filename generation
setopt MARK_DIRS

# ===== History
# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY
# Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
# setopt EXTENDED_HISTORY
# Add commands as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY
# If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event
setopt HIST_EXPIRE_DUPS_FIRST
# Do not enter command lines into the history list if they are duplicates of the previous event
setopt HIST_IGNORE_DUPS
# remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE
# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# # ===== Completion
# # show completion menu on successive tab press ... needs unsetop menu_complete to work
# setopt AUTO_MENU
# # automatically list choices on an ambiguous completion
# setopt AUTO_LIST
# # when listing files that are possible completions, show the type of each file with a trailing identifying mark
# setopt LIST_TYPES
# # extra completion
# setopt COMPLETE_ALIASES
# # if unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends
# setopt COMPLETE_IN_WORD
# # if a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word
# setopt ALWAYS_TO_END

# # do not autoselect the first completion entry
# unsetopt MENU_COMPLETE
# # do not set auto_name_dirs because it messes up prompts (any parameter that is set to the absolute name of a directory immediately becomes a name for that directory)
# unsetopt AUTO_NAME_DIRS
 #CASE_SENSITIVE="false"
# Load syntax highlighting; should be last according to Luke.

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
