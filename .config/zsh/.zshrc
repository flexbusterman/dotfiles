# Augustins version of Luke's config for the Zoomer Shell!

# no duplicates in history
HISTFILE=/home/flex/.history/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
path+=($HOME/.ghcup/bin)
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

# bind ctrl+space accept completion
bindkey -r '^L'
bindkey '^L' autosuggest-accept

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^K" up-line-or-beginning-search # Up
bindkey "^J" down-line-or-beginning-search # Down

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
# autoload -U compinit
# zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)   # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1
export MPD_HOST=127.0.0.1
export MPD_PORT=6600


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
source /home/flex/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# vi mode
bindkey -v
export KEYTIMEOUT=1

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
#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
# aliases

# Misc aliases
alias bs='browser-sync start --server --no-notify --files "*"'
alias cat="bat"
alias copy='xclip -sel clip'
alias ct="cointop"
alias de='find . -empty -type d -delete'
alias dot='/usr/bin/git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias du="du -hs ."
alias du='du -h'
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias gb="git branch"
alias grep="grep --color=always -i"
alias igdlinitl="cd ~/Dropbox/MEMES && instaloader --login _christian_augustin --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeforyouandhim"
alias igdlinit="cd ~/Dropbox/MEMES && instaloader --login _christian_augustin --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeseducational dank_memes_world_1 dank_memes_world_1 zucktheberg stinky420memes memes epicallyepicmemes baked_meme_god stolenmemesawakens memesinyourdms omgzucc"
alias igdll="cd ~/Dropbox/MEMES && instaloader -F --login _christian_augustin --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeforyouandhim"
alias igdl="cd ~/Dropbox/MEMES && instaloader -F --no-video-thumbnails --no-metadata-json --no-captions --no-profile-pic memeseducational dank_memes_world_1 dank_memes_world_1 zucktheberg stinky420memes memes epicallyepicmemes baked_meme_god stolenmemesawakens memesinyourdms omgzucc"
alias la="exa -la"
alias lag="exa -la | grep --color=always -i"
alias less="bat"
alias lm="exa -la --sort=modified"
alias ls="exa"
alias lsg="exa | grep --color=always -i"
alias lt="exa -lar --sort=size"
alias mc="mullvad connect"
alias md="mullvad disconnect"
alias ms="mullvad status"
alias np="deadbeef --nowplaying %d/%f"
alias play="ffplay -nodisp -autoexit"
alias pw="openssl rand -base64 41 | xclip -sel clip"
alias q="exit"
alias ra="pulseaudio --kill; jack_control start; jack_control exit; pulseaudio --start;"
alias res="xdpyinfo | awk '/dimensions/{print $2}'"
alias rf='rm -rf'
alias shs="simple-http-server"
alias ud='sudo updatedb'
alias vim="nvim"
alias wine32="WINEPREFIX=~/.wine32 WINEARCH=win32"

# Navigation shortcuts
alias b='cd ~/.local/bin/; exa'
alias D='cd ~/Downloads; exa'
alias d='cd ~/Dropbox; exa'
alias mn='cd ~/GIT/mind; npm run dev'
alias s='cd ~/Dropbox/2021\ FOTO/SCREENSHOTS; exa'
alias sn='cd ~/GIT/sandhamn; npm run dev'
alias sv='cd ~/GIT/sandhamn; nvim'

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
alias wd="nmcli device disconnect wlp2s0"
wrm() { nmcli con delete $* }
wc() { nmcli device wifi connect $1 password $2 }
wdisable() { nmcli connection down $* }

# VIM aliases for editing common files
alias vA="cd /home/flex/.config/alacritty/; nvim alacritty.yml"
alias va="cd /home/flex/.local/bin/; nvim augustin"
alias vc="cd /home/flex/.config/nvim/; nvim coc-settings.json"
alias vD="cd /home/flex/.local/src/dmenu/; nvim config.h"
alias vd="cd /home/flex/.local/src/dwm-flexipatch/; nvim config.h"
alias vn="cd /home/flex/.config/nvim/; nvim init.vim"
alias vP="cd /home/flex/.config/nvim/; nvim plugins.vim"
alias vp="cd /home/flex/.local/src/dwm-flexipatch/; nvim patches.h"
alias vP="cd /home/flex/; nvim .xprofile"
alias vs="cd /home/flex/.config/coc/ultisnips; nvim all.snippets"
alias vS="cd /home/flex/.local/src/st/; nvim config.h"
alias vu="cd /home/flex/.config/newsboat/; nvim urls"
alias vv="cd /home/flex/.config/vifm/; nvim vifmrc"
alias vX="cd /home/flex/.xmobar/; nvim xmobar.hs"
alias vx="cd /home/flex/.xmonad/; nvim xmonad.hs"
alias vz="cd /home/flex/.config/zsh/; nvim .zshrc"

# Keymap aliases
alias se="setxkbmap se; setxkbmap -option caps:swapescape; xset r rate 300 50"
alias us="setxkbmap us; setxkbmap -option caps:swapescape; xset r rate 300 50"

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

datefolder(){
for f in $*
do
	if [ -z "$('ls' -A $f)" ]
	then
	elif [ -d "$f" ]
	then
		cd "$f"
		NEWEST=$(date +"%Y%m%d")
		for file in *
		do
			if [ -f $file ]
			then
				if [ $(date -r $file +"%Y%m%d") -le $NEWEST ]
				then
					NEWEST=$(date -r "$file" +"%Y%m%d")
				fi
			fi
		done
		cd ..
		YEAR=$(echo $NEWEST | cut -c 1-4)
		MONTH=$(echo $NEWEST | cut -c 5-6)
		DAY=$(echo $NEWEST | cut -c 7-8)
		RESULT="$YEAR-$MONTH-$DAY $f"
		if [[ $f =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}.* ]]
		then
			echo "$f already begins with date"
		else
			echo "Renaming: $f => $RESULT"
			mv $f $RESULT
		fi
	fi
done
}

datefile(){
	for f in $*
	do
		if [ -f "$f" ]
		then
			DATE=$(date -r "$f" +"%Y%m%d")
			YEAR=$(echo $DATE | cut -c 1-4)
			MONTH=$(echo $DATE | cut -c 5-6)
			DAY=$(echo $DATE | cut -c 7-8)
			RESULT="$YEAR-$MONTH-$DAY $f"
			# if [[ $f =~ ^[0-9]{4}-.*$ ]]
			if [[ $f =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}.* ]]
			then
				echo "$f already begins with date"
			else
				echo "Renaming: $f => $RESULT"
				mv $f $RESULT
			fi
		fi
	done
}

train(){
	st -e zsh -c "libreoffice /home/flex/Dropbox/DROPSYNC/\!\ TRANSFER/Beginner\ Template\ Augustin.xlsx" &
	termdown --no-figlet
}

t(){
	termdown --no-figlet $*
}

tf(){
	termdown --no-figlet $* && ffplay -nodisp -autoexit /home/flex/Dropbox/MUSIC/MP3/fanfare.mp3
}

beer(){
	while true
	do
		echo '                       '
		echo '  .   *   ..  . *  *   '
		echo '*  * @()Ooc()*   o  .  '
		echo '    (Q@*0CG*O()  ___   '
		echo '   |\_________/|/ _ \  '
		echo '   |  |  |  |  | / | | '
		echo '   |  |  |  |  | | | | '
		echo '   |  |  |  |  | | | | '
		echo '   |  |  |  |  | | | | '
		echo '   |  |  |  |  | | | | '
		echo '   |  |  |  |  | \_| | '
		echo '   |  |  |  |  |\___/  '
		echo '   |\_|__|__|_/|       '
		echo '    \_________/        '
		echo '                       '
		sleep 5
	done
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

hg() { history 0 | grep --color=always -i $* }

mind() {
	cd /home/flex/GIT/mind
	st -t dev -e zsh -c "cd ~/GIT/mind/; zsh -c \"npm run dev\"" &
	sleep 2
	firefox --devtools --new-window localhost:8000 &
	firefox --new-window https://xd.adobe.com/view/035ce4d8-ddd4-4c00-752c-3f6187a5d998-756d/grid &
	st -t wiki -e zsh -c "cd ~/Documents/; nvim Scandinavian\ Mind.wiki" &
	st -t terminal -e zsh -c "cd ~/GIT/mind/; eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/mind;" &
	# sleep 0.5
	st -t main -e zsh -c "cd ~/GIT/mind/; eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/mind; cd ~/GIT/mind/; nvim pages/index.vue;" &
}

dev() {
	# st -e cd ~/GIT/$* &
	# st -e cd ~/GIT/$*; &
	st -t Dev -e zsh -c "cd ~/GIT/$*/; nvim index.html" &
	cd ~/GIT/$*;
	browser-sync start --server --no-notify --files "*"
	# st -e zsh -c "cd ~/Documents/; nvim -c \"autocmd! CursorHold * CocDisable\" Buffalo\ Bill\ Gates.wiki" &
	# cd ~/GIT/kalle2019/; nvim;
}

# aug() {
  # st -t SuperCollider -e zsh -c "cd ~/Dropbox/; nvim -c \"NERDTreeToggle | set filetype=supercollider | SCNvimStart\"" &
  # bitwig-studio &
  # st -t aug -e zsh -c "sleep 5; aconnect 128:7 16:0"
# }

# aug() {
  # st -t SuperCollider -e zsh -c "cd ~/Dropbox/SUPERCOLLIDER; nvim -O ~/Dropbox/SUPERCOLLIDER/2021-03-15\ Augustin\ Piece\ 001.sc ~/Dropbox/SUPERCOLLIDER/2021-03-15\ Augustin\ Setup\ 001.sc -c \"set filetype=supercollider | SCNvimStart\"" &
  # # bitwig-studio &
  # # st -t aug -e zsh -c "sleep 5; aconnect 128:7 16:0"
# }

# Locate and Edit
le(){
	locate $* | sed 1q | xargs nvim
}

# Find Recursively and case-insensitive
fr(){
find . -path '**' -iname '$*'
}

gp() {
  result="\"$*\""
  git add .
  git commit -m $result
  git push
}

gpd() {
  result="\"$*\""
  git add .
  git commit -m $result
  git push origin dev
}


dp() {
  result="\"$*\""
  dot add -u
  dot commit -m $result
  dot push
}

# Add ssh tokens
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/git
ssh-add ~/.ssh/id_ed25519
clear

# Load syntax highlighting; should be last according to Luke.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source ~/GIT/zsh-autocomplete/zsh-autocomplete.plugin.zsh
