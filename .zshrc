# use temporary prompt while loading plugins
# source ~/.zsh/plugins/instant-zsh/instant-zsh.zsh
# instant-zsh-pre "%B%F{1}[%F{3}%n%F{2}@%F{4}%M %F{5}%~%F{1}]%f$%b "

export MPD_HOST=127.0.0.1

# NVM_LAZY_LOAD=true
HISTFILE=~/.history/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
path+=($HOME/.ghcup/bin)
path+=($HOME/go/bin/)
path+=($HOME/.cabal/bin/)

source ~/.zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
# source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/plugins/zsh-nvm/zsh-nvm.plugin.zsh
source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh

# nixos
# if [ -n "${commands[fzf-share]}" ]; then
#   source "$(fzf-share)/key-bindings.zsh"
#   source "$(fzf-share)/completion.zsh"
# fi

setopt APPEND_HISTORY # Allow multiple terminal sessions to all append to one zsh command history
setopt autocd   # Automatically cd into typed directory.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt HIST_BEEP                 # Beep when accessing nonexisten
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt MARK_DIRS # append a trailing ‘/’ to all directory names resulting from filename generation
setopt SHARE_HISTORY             # Share history between all sessions.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

stty stop undef   # Disable ctrl-s to freeze terminal.

# bind ctrl+space accept completion
# bindkey -r '^L'
# bindkey '^L' autosuggest-accept

# bash like command edit in editor (nvim)
# export VISUAL=nvim
# autoload edit-command-line; zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# autoload -U up-line-or-beginning-search
# autoload -U down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey "^K" up-line-or-beginning-search # Up
bindkey "^R" history-incremental-pattern-search-backward
# bindkey "^J" down-line-or-beginning-search # Down

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

zle     -N            fzf-cd-widget
bindkey -M emacs '^x' fzf-cd-widget
bindkey -M vicmd '^x' fzf-cd-widget
bindkey -M viins '^x' fzf-cd-widget

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# PS1="%B%{$fg[blue]%}>%{$reset_color%}%b "

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# # vi mode
# bindkey -v
# export KEYTIMEOUT=1
# # export MPD_PORT=6600
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
# aliases

# Misc aliases
alias bs='browser-sync start --server --no-notify --files "**/*"'
alias cat="bat"
alias copy='xclip -sel clip'
alias ct="cointop"
alias de='find . -empty -type d -delete'
alias dot='/usr/bin/env git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias du='du -h'
# alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias gb="git branch"
# alias grep="grep --color=always -i"
alias la="exa -la --group-directories-first"
alias lg="exa -la | grep --color=always -i"
alias less="bat"
alias lm="exa -la --sort=modified"
alias ls="exa"
alias lt="exa -lar --sort=size"
alias mc="mullvad connect"
alias md="mullvad disconnect"
alias pw="openssl rand -base64 41 | xclip -sel clip"
alias q="exit"
alias res="xdpyinfo | awk '/dimensions/{print $2}'"
alias rf='rm -rf'
alias shs="simple-http-server"
alias ud='sudo updatedb'
alias vim="nvim"
alias wine32="WINEPREFIX=~/.wine32 WINEARCH=win32"
alias mnt="sudo mount -o loop $* /mnt/ISO/"
alias vimdiff='nvim -d'
alias gs="git status"
alias ta="tmux attach -t "
alias tam="tmux attach -t main"
alias td="tmux detach"
alias tks="tmux kill-server"
alias pg="ping google.com"
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias sz="source ~/.zshrc"
alias xb="sudo cp -rv /etc/X11/ ~/.config/etcfiles/"
alias lf="lfrun"
alias pi="paru -Syu --needed $* && remaps"

# audio
alias play="ffplay -nodisp -autoexit"
alias np="deadbeef --nowplaying %d/%f"
alias dq="deadbeef --quit"
alias j="jack_control"
alias jls="jack_control status"
alias jk="jack_control stop; killall a2jmidid"
alias js="jack_control start"
alias par="pulseaudio --kill; jack_control start; jack_control exit; pulseaudio --start;"
alias pak="pulseaudio --kill;"
alias pas="pulseaudio --start;"
alias pa="pulseaudio"
alias ra="sudo alsa force-reload"
alias al="asoundconf"
alias als="asoundconf is-active"
alias alls="asoundconf list-all"
alias ald="asoundconf set-default-card"

# Dropbox aliases
alias dadd="dropbox-cli exclude remove"
alias deg="dropbox-cli exclude | grep --color=always -i"
alias dls="dropbox-cli ls"
alias dr='dropbox-cli restart'
alias drm="dropbox-cli exclude add"
alias drma="ls | sed 's/ /\\ /g' | sed 's/'\''/\\'\''/g' | xargs dropbox-cli exclude add"
alias ds='dropbox-cli status'
alias dsl="dropbox-cli sharelink | xclip -sel clip"

# WIFI connection aliases
alias wls="nmcli dev wifi"
alias wla="nmcli c"
alias ws="nmcli device status"
alias wd"nmcli device disconnect $(nmcli device | awk '/^w/ {print $1}')"
# alias wrm='f() { nmcli con delete $*};f'
alias wrm='nmcli con delete'
# alias wconnect='f() { nmcli device wifi connect $1 password $2 };f'
# alias wconnect='nmcli device wifi connect'
# alias wdisable='f() { nmcli connection down $* };f'
# alias wdisable='nmcli connection down'
alias ndwc="nmcli device wifi connect"

# Keymap aliases
alias se="setxkbmap se; setxkbmap -option caps:swapescape; xset r rate 300 50"
alias us="setxkbmap us; setxkbmap -option caps:swapescape; xset r rate 300 50"

# memes
alias igdlinitl="cd ~/Dropbox/MEMES && instaloader --login _christian_augustin --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeforyouandhim"
alias igdlinit="cd ~/Dropbox/MEMES && instaloader --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeseducational dank_memes_world_1 dank_memes_world_1 casual.nihilism mvme.hub memefolk.ig stinky420memes memes epicallyepicmemes baked_meme_god stolenmemesawakens memesinyourdms omgzucc"
alias igdll="cd ~/Dropbox/MEMES && instaloader -F --login _christian_augustin --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeforyouandhim"
alias igdl="cd ~/Dropbox/MEMES && instaloader -F --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeseducational dank_memes_world_1 dank_memes_world_1 casual.nihilism mvme.hub memefolk.ig stinky420memes memes epicallyepicmemes baked_meme_god stolenmemesawakens memesinyourdms omgzucc"

# shortcuts
alias vz="cd ~; nvim .zshrc"

# alias hr="home-manager switch"
alias nr="sudo nixos-rebuild switch --flake /home/flex/.flarbs"
alias hr="home-manager switch --flake /home/flex/.flarbs"
# update flarbs and home manager
alias nu="sudo nix flake update /home/flex/.flarbs"

alias locate="locate -i"

alias sw='echo $PWD > ~/.workdir'
alias cw='cd "$(cat ~/.workdir)"'

# navigation
alias d='cd ~/Dropbox/'
alias D='cd ~/Downloads/'
alias c='cd ~/.config/'
alias b='cd ~/.local/bin/'
alias m='cd /run/media/$USER/'
alias g='cd ~/.local/src/'
alias f='cd ~/.flarbs/'

#   __                  _   _
#  / _|_   _ _ __   ___| |_(_) ___  _ __  ___
# | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
# functions

dag () {
	dropbox-cli exclude | command grep -i $* | xargs -d '\n' dropbox-cli exclude remove
}

ytd () { youtube-dl --add-metadata -i "$*"}
ytda () { youtube-dl --add-metadata -i -x -f bestaudio/best "$*"}
ya () { ytfzf -mad "$*"}

# Pacman shortcut functions
pin () { sudo pacman -S --noconfirm $* }
pun () { sudo pacman -Rns $* }
prm () { sudo pacman -Rns $* }
pup () { sudo pacman -Syu }
pf (){ pacman -Ss "$*" }
pls (){ pacman -Qe }
pla (){ pacman -Q }
pc (){ sudo pacman -Scc }

# Yay install without confirmations
yin () { yay --save --answerclean All --answerdiff All -Syu $* }

yun () { yay -Rs $* }
yrm () { yay -Rs $* }
yup () { yay --nocleanmenu --nodiffmenu -Syu }
yf () { yay -Ss $* }
yls () { yay -Q }

underscorefolder(){
for f in *; do
	if [ -d "$f" ]; then
		# check current folder for subfolders ending with underscore
		if [[ $f =~ ^.*_ ]]; then
			mkdir -p "${f%??}"
			# move and overwrite all files ./folder_/* ./folder/
			# remove folder_
		fi
	fi
done
}

datefolder(){
}

tf(){
	termdown --no-figlet $* && ffplay -nodisp -autoexit ~/Dropbox/MUSIC/MP3/fanfare.mp3
}

t(){
  termdown --no-figlet $* && notify-send "$* has passed"
}

# pdf2mp3() {
	# pdftotext $* | sed ebook.txt
	# espeak -f ebook.txt -w ebook_audio.wav
	# mplayer ebook_audio.wav
# }

# ssh add function
sa() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$*
}

# prepend date
pd() {
  date=$(date +%F)
  mv "$*" "$date $*"
}

merge() {
	# unsetopt CASE_GLOB
	echo
	for i in $*; do
		find . -maxdepth 1 -iname "$i*[^temporary]"
		read REPLY\?"Merge files? (Y/y) "
		if [[ $REPLY == [yY] ]]; then
			read NAME\?"Target filename: "
			find . -maxdepth 1 -iname "$i*[^temporary]" -exec cat '{}' >> $NAME.temporary \;
			mkdir -p old
			find . -maxdepth 1 -iname "$i*[^temporary]" -exec mv '{}' ./old \;
			mv $NAME.temporary $NAME
		fi
	done
}

hg() { history 0 | grep --color=always -i $* }

# Locate and Edit
le(){
	locate $* | sed 1q | xargs nvim
}

# Find Recursively and case-insensitive
# fr(){
#   find . -path '**' -iname '$*'
# }

gp() {
	eval "$(ssh-agent -s)"
	# ssh-add all files without extension
	ssh-add ~/.ssh/git
  result="$*"
  git add .
  git commit -m $result
  git push
}

pass() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/digitalocean
	command pass $*
}

gpd() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="\"$*\""
  git add .
  git commit -m $result
	git push origin dev
}

dp() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="$*"
  dot add -u
  dot commit -m $result
  dot push
}

pdp() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/git
  result="$*"
  /usr/bin/env git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME add -u
  /usr/bin/env git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME commit -m $result
  /usr/bin/env git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME push
}

alias dot="/usr/bin/env git --git-dir=$HOME/.dot.git/ --work-tree=$HOME"
alias pdot="/usr/bin/env git --git-dir=$HOME/.pdot.git/ --work-tree=$HOME"

export XDG_CONFIG_HOME=~/.config

LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

# source /usr/share/nvm/init-nvm.sh
# [ -f /opt/mambaforge/etc/profile.d/conda.sh ] && source /opt/mambaforge/etc/profile.d/conda.sh
#

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# in your/custom/path you need to have a "plugins" folder and in there you clone the repository as zsh_codex
# export ZSH_CUSTOM="$HOME/.zsh/"
# source "$ZSH_CUSTOM/plugins/zsh_codex/zsh_codex.plugin.zsh"
# bindkey '^X' create_completion

# eval "$(zoxide init --cmd cd zsh)"

# Load syntax highlighting; should be last according to Luke Smith.
# source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# instant-zsh-post

source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# bash mode
bindkey -e
