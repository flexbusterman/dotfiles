# Augustins version of Luke's config for the Zoomer Shell!

# no duplicates in history
HISTFILE=/home/flex/.history/zsh/history
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

# (cat ~/.cache/wal/sequences &)

# zplug plugin manager
source ~/.zplug/init.zsh
zplug "simnalamburt/zsh-expand-all"
# zplug "momo-lab/zsh-abbrev-alias"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
		printf "Install? [y/N]: "
		if read -q; then
				echo; zplug install
		fi
fi

# trying out oh my zsh

# if you come from bash you might have to change your $path.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/flex/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=()
# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
source /home/flex/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Load syntax highlighting; should be last according to Luke.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

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


# Other aliases
alias ls="exa"
alias lsg="exa | grep --color=always -i"
alias la="exa -la"
alias lag="exa -la | grep --color=always -i"
alias lm="exa -la --sort=modified"
alias lt="exa -lar --sort=size"
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias copy='xclip -sel clip'
alias rf='rm -rf'
alias res="xdpyinfo | awk '/dimensions/{print $2}'"
alias q="exit"
alias ig="brave --app=\"http://www.instagram.com/direct/inbox/\""
alias igdl="instalooter -u augustinsupremacy user memeforyouandhim /home/flex/Dropbox/MEMES/memeforyouandhim -N && instalooter user memeseducational ~/Dropbox/MEMES/memeseducational -N && instalooter user dank_memes_world_1 /home/flex/Dropbox/MEMES/dank_memes_world_1 -N && instalooter user zucktheberg /home/flex/Dropbox/MEMES/zucktheberg -N && instalooter user stinky420memes /home/flex/Dropbox/MEMES/stinky420memes -N && instalooter user memes.to.dm /home/flex/Dropbox/MEMES/memes.to.dm -N && instalooter user epicallyepicmemes /home/flex/Dropbox/MEMES/epicallyepicmemes -N && instalooter user baked_meme_god /home/flex/Dropbox/MEMES/baked_meme_god -N && instalooter user stolenmemesawakens /home/flex/Dropbox/MEMES/stolenmemesawakens -N && instalooter user memesinyourdms /home/flex/Dropbox/MEMES/memesinyourdms -N && instalooter user omgzucc /home/flex/Dropbox/MEMES/omgzucc -N"

alias gb="git branch"
alias ra="pulseaudio --kill; jack_control start; jack_control exit; pulseaudio --start;"
alias vim="nvim"
alias dot='/usr/bin/git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
alias bs='browser-sync start --server --directory --files "*"'
alias grep="grep --color=always -i"
# alias live="wine64 /home/flex/Wine/Program\ Files/Ableton/Live\ 10\ Suite/Program/Ableton\ Live\ 10\ Suite.exe"
alias ud='sudo updatedb'
alias du='du -h'
alias de='find . -empty -type d -delete'
alias du="du -hs ."
alias play="ffplay -nodisp -autoexit"
alias np="deadbeef --nowplaying %d/%f"

# Navigation shortcuts
alias d='cd ~/Dropbox; exa'
alias D='cd ~/Downloads; exa'

# Dropbox aliases
alias dls="dropbox-cli ls"
alias deg="dropbox-cli exclude | grep --color=always -i"
alias drm="dropbox-cli exclude add"
alias drma="ls | sed 's/ /\\ /g' | sed 's/'\''/\\'\''/g' | xargs dropbox-cli exclude add"
alias dsl="dropbox-cli sharelink"
alias dadd="dropbox-cli exclude remove"
alias pw="date +%s | sha256sum | base64 | head -c 32 | xclip -sel clip"
alias ms="mullvad status"
alias mc="mullvad connect"
alias md="mullvad disconnect"

dag () {
	dropbox-cli exclude | command grep -i $* | xargs -d '\n' dropbox-cli exclude remove
}

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

# VIM aliases for editing common files
alias vz="cd /home/flex/.config/zsh/; nvim .zshrc"
alias vx="cd /home/flex/; nvim .xprofile"
alias vn="cd /home/flex/.config/nvim/; nvim init.vim"
alias vp="cd /home/flex/.config/nvim/; nvim plugins.vim"
alias vu="cd /home/flex/.config/newsboat/; nvim urls"
alias vd="cd /home/flex/.local/src/dwm/; nvim config.h"
alias vs="cd /home/flex/.local/src/st/; nvim config.h"
alias vc="cd /home/flex/.config/nvim/; nvim coc-settings.json"
alias vv="cd /home/flex/.config/vifm/; nvim vifmrc"

# Keymap aliases
alias se="setxkbmap se; setxkbmap -option caps:swapescape; xset r rate 300 50"
alias us="setxkbmap us; setxkbmap -option caps:swapescape; xset r rate 300 50"

yt () { youtube-dl --add-metadata -i "$*"}
yta () { youtube-dl --add-metadata -i -x -f bestaudio/best "$*"}

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

yun () { yaourt -Rs $* }
yrm () { yaourt -Rs $* }
yup () { yaourt -Syua --noconfirm}
yf () { yaourt -Ss $* }
yls () { yaourt -Q }

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
	termdown --no-figlet $* && ffplay -nodisp -autoexit /home/flex/Dropbox/MUSIC/fanfare.mp3
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
  st -e zsh -c "cd ~/GIT/kalle2019; zsh -c \"npm run dev\"" &
  st -e zsh -c "cd ~/Documents/; nvim -c \"autocmd! CursorHold * CocDisable\" Buffalo\ Bill\ Gates.wiki" &
  cd ~/GIT/kalle2019/; nvim;
}

aug() {
  st -t SuperCollider -e zsh -c "cd ~/Dropbox/; nvim -c \"NERDTreeToggle | set filetype=supercollider | SCNvimStart\"" &
  bitwig-studio &
  st -t aug -e zsh -c "sleep 5; aconnect 128:7 16:0"
}

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
#Aggressive autocomplete
#autoload predict-on
#predict-on

# Add ssh tokens
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/flexgit
ssh-add ~/.ssh/bitbucket
ssh-add ~/.ssh/drop
ssh-add ~/.ssh/mind
clear

zplug load

# expand-alias-and-accept-line() {
    # __abbrev_alias::magic_abbrev_expand
    # # zle .backward-delete-char # this prevets a ^M character from ending up as part of the command
    # zle .accept-line
# }

# zle -N accept-line expand-alias-and-accept-line
#

