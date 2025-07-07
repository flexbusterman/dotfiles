#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

[[ $- = *i* ]] && source /usr/bin/liquidprompt

if [ -n "$BASH_VERSION" ]; then
  eval "$(fzf --bash)"
fi

# [[ $- == *i* ]] && source /usr/share/blesh/ble.sh # syntax highlighting and other features

# history
HISTSIZE=10000000
SAVEHIST=10000000
HISTCONTROL=ignoredups # Ignore duplicate commands in a row
HISTCONTROL=erasedups # Ignore all previous duplicates (not just consecutive)
HISTCONTROL="${HISTCONTROL}:ignorespace" # Do not record commands that start with a space
HISTCONTROL="${HISTCONTROL}:erasedups" # Do not write duplicate lines to the history file

export MANPAGER='nvim +Man!'
alias dot='/usr/bin/git --git-dir=/home/flex/.dot.git/ --work-tree=/home/flex'
