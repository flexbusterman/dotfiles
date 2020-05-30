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

alias fs="df -h | grep --color='never' 'Filesystem\|sd'"
# alias dl="cd ~/dl/"
alias copy='xclip -sel clip'
# alias yt='nohup google-chrome http://www.youtube.com >> /dev/null > exhibitor.out 2>&1 & && disown && jobs -q'
alias vim='nvim'
# alias nvim='/usr/bin/nvim.appimage'
# make build and git commit with message
# function makedwm
#         set result (string join ' ' $argv)
# #       set result "'"$result"'"
# pushd ~/GIT/dwm/
#         git add .
#         git commit -m $result
#         make
#         sudo make clean install
#         popd
# end

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function pi
	sudo pacman -S --noconfirm $argv
end

function pr
	sudo pacman -Rv --noconfirm $argv
end

function gp
        set result (string join ' ' $argv)
#       set result "'"$result"'"
        git add .
        git commit -m $result
        git push
end

# start google chrome with argument as address
function c
        set result (string join ' ' $argv)
        nohup google-chrome http://$result  >> /dev/null > exhibitor.out 2>&1 & && disown (jobs -p)
	i3-msg workspace 2
end

fish_vi_key_bindings
