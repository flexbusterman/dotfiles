#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

[[ $- = *i* ]] && source /usr/bin/liquidprompt

# Enable fzf key bindings and completion (recommended way)
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# [[ $- == *i* ]] && source /usr/share/blesh/ble.sh # syntax highlighting and other features

# history
export HISTFILE=~/.bash_history
HISTSIZE=10000000
SAVEHIST=10000000
HISTCONTROL=ignoredups:erasedups

export MANPAGER='nvim +Man!'
alias dot='/usr/bin/git --git-dir=/home/flex/.dot.git/ --work-tree=/home/flex'
alias pdot='/usr/bin/git --git-dir=/home/flex/.pdot.git/ --work-tree=/home/flex'
