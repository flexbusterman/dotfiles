#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[[ $- = *i* ]] && source /usr/bin/liquidprompt

eval "$(fzf --bash)" # Set up fzf key bindings and fuzzy completion

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh # syntax highlighting and other features

# history
HISTSIZE=10000000
SAVEHIST=10000000
# Ignore duplicate commands in a row
HISTCONTROL=ignoredups

# Ignore all previous duplicates (not just consecutive)
HISTCONTROL=erasedups

# Do not record commands that start with a space
HISTCONTROL="${HISTCONTROL}:ignorespace"

# Do not write duplicate lines to the history file
HISTCONTROL="${HISTCONTROL}:erasedups"
