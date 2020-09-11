# Augustins version of Luke's config for the Zoomer Shell

# no duplicates in history
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexisten

alias vim="nvim"
alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'

# Dropbox aliases
alias dls="dropbox-cli ls"
alias drm="dropbox-cli exclude add"
alias dsl="dropbox-cli sharelink"
alias dadd="dropbox-cli exclude remove"
alias ds='dropbox-cli status'
alias dr='dropbox-cli restart'

# WIFI connection aliases
alias wls="nmcli dev wifi"
alias wla="nmcli c"
alias ws="nmcli device status"
alias wd="nmcli device disconnect"
wrm() { nmcli con delete $* }
wc() { nmcli device wifi connect $1 password $2 }
wdisable() { nmcli connection down $* }

alias la="exa -la"
alias ls="exa"
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias copy='xclip -sel clip'
alias rf='rm -rf'
alias res="xdpyinfo | awk '/dimensions/{print $2}'"
alias q="exit"

# VIM aliases for editing common files
alias vz="cd /home/flex/.config/zsh/; nvim .zshrc"
alias vx="cd /home/flex/; nvim .xprofile"
alias vn="cd /home/flex/.config/nvim/; nvim init.vim"
alias vp="cd /home/flex/.config/nvim/; nvim plugins.vim"
alias vu="cd /home/flex/.config/newsboat/; nvim urls"
alias vd="cd /home/flex/.local/src/dwm/; nvim config.h"
alias vs="cd /home/flex/.local/src/st/; nvim config.h"
alias vc="cd /home/flex/.config/nvim/; nvim coc-settings.json"

# Keymap aliases
alias se="setxkbmap se; setxkbmap -option caps:swapescape; xset r rate 300 50"
alias us="setxkbmap us; setxkbmap -option caps:swapescape; xset r rate 300 50"

# Other aliases
alias poe="cd ~/.local/share/wineprefixes/default/drive_c/Program\ Files\ \(x86\)/Grinding\ Gear\ Games/Path\ of\ Exile/; wine PathOfExile_x64.exe"
alias gb="git branch"

# Pacman shortcut functions
pin () { sudo pacman -S --noconfirm $* }
pun () { sudo pacman -Rns $* }
prm () { sudo pacman -Rns $* }
pup () { sudo pacman -Syu }
pf (){ pacman -Ss "$*" }
pls (){ pacman -Qe }
pla (){ pacman -Q }
pc (){ sudo pacman -Scc }

# Yaourt shortcuts functions
yin () { yaourt -S --noconfirm $* }
yun () { yaourt -Rs $* }
yrm () { yaourt -Rs $* }
yup () { yaourt -Syua --noconfirm}
yf () { yaourt -Ss $* }
yls () { yaourt -Q }

# ssh add function
sa () {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$*
}

# prepend date
pd () {
  date=$(date +%F)
  mv "$*" "$date $*"
}

# git functions
gp () {
  result="\"$*\""
  git add .
  git commit -m $result
  git push
}

gpd () {
  result="\"$*\""
  git add .
  git commit -m $result
  git push origin dev
}


dp () {
  result="\"$*\""
  dot add -u
  dot commit -m $result
  dot push
}

hg () {
  result=$*
  history 0 | grep $result
}

mind () {
	st -t dev -e zsh -c "cd ~/GIT/mind/; zsh -c \"npm run dev\"" &
	sleep 2
	firefox --devtools --new-window localhost:8000 &
	firefox --new-window https://xd.adobe.com/view/035ce4d8-ddd4-4c00-752c-3f6187a5d998-756d/grid &
	st -t wiki -e zsh -c "cd ~/Documents/; nvim Scandinavian\ Mind.wiki" &
	st -t terminal -e zsh -c "cd ~/GIT/mind/; eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/mind;" &
	# sleep 0.5
	st -t main -e zsh -c "cd ~/GIT/mind/; nvim -O pages/index.vue layouts/default.vue;" &
}

dev () {
  st -e zsh -c "cd ~/GIT/kalle2019; zsh -c \"npm run dev\"" &
  st -e zsh -c "cd ~/Documents/; nvim -c \"autocmd! CursorHold * CocDisable\" Buffalo\ Bill\ Gates.wiki" &
  cd ~/GIT/kalle2019/; nvim;
}

# landing () {
	# st -e zsh -c "cd ~/GIT/landing/; zsh -c \"npm run dev\"" &
	# st -e firefox -new-instance https://xd.adobe.com/view/035ce4d8-ddd4-4c00-752c-3f6187a5d998-756d/grid &
	# st -e firefox -new-instance localhost:8000 &
	# st -e zsh -c "cd ~/Documents/; nvim Scandinavian\ Mind.wiki" &
	# st -e zsh -c "cd ~/GIT/landing/; eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/mind;" &
	# sleep 1
	# st -e zsh -c "cd ~/GIT/landing/; eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/mind; nvim -O pages/index.vue layouts/default.vue;" &
# }

aug () {
  st -e zsh -c "cd ~/Dropbox/\!\ SUPERCOLLIDER/; nvim 2020-09-09\ SuperCollider\ MIDI\ Bitwig\ 002.sc" &
  patchage &
  bitwig-studio &
}

#Aggressive autocomplete
#autoload predict-on
#predict-on

# Add ssh tokens
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
ssh-add ~/.ssh/bitbucket
ssh-add ~/.ssh/drop
ssh-add ~/.ssh/mind
clear

# bind ctrl+space accept completion
bindkey -r '^L'
bindkey '^L' autosuggest-accept

# bindkey -r -M vicmd 'k'
# j
# bindkey -r -M vicmd 'j'
# bindkey -M vicmd "j" history-beginning-search-forward

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^K" up-line-or-beginning-search # Up
bindkey "^J" down-line-or-beginning-search # Down

#   _          _
#  | |   _   _| | _____
#  | |  | | | | |/ / _ \
#  | |__| |_| |   <  __/
#  |_____\__,_|_|\_\___|

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd   # Automatically cd into typed directory.
stty stop undef   # Disable ctrl-s to freeze terminal.

# History in cache directory:

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

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# flex
bindkey -v '^H' vi-backward-kill-word

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
