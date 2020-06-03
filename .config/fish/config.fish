# /etc/fish/config.fish

# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status --is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status --is-interactive
#   ...
# end
alias la="exa -la"
alias ls="exa"
alias reaper="/home/flex/opt/REAPER/reaper"
alias ranger="/home/flex/.local/src/ranger/ranger.py"
alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
alias copy='xclip -sel clip'
alias vim='nvim'
# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias rf='rm -rf'
function in
	# sudo apt -y install $argv
        sudo pacman -S --noconfirm $argv
end

function un
	# sudo apt -y remove $argv
        sudo pacman -R --noconfirm $argv
end

# function to prepend date to filename
function pd
  set date (date +%F)
  mv "$argv" "$date $argv"
end

function gp
        set result (string join ' ' $argv)
        git add .
        git commit -m $result
        git push
end

function dp
        set result (string join ' ' $argv)
        dot add -u
        dot commit -m $result
        dot push
end

# start google chrome with argument as address
function c
        set result (string join ' ' $argv)
        nohup google-chrome http://$result  >> /dev/null > exhibitor.out 2>&1 & && disown (jobs -p)
	i3-msg workspace 2
end

fish_vi_key_bindings
fish_ssh_agent
ssh-add ~/.ssh/github
ssh-add ~/.ssh/bitbucket
clear
set -gx PATH $PATH /home/flex/.cargo/bin
