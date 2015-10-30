#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export LANG=en_US.UTF-8
export TERM=rxvt-unicode
export BSPWM_SOCKET=/tmp/bspwm-socket
export SANDFLY_DIR=/home/davids/gits/sandfly

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
