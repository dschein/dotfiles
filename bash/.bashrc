# If not running interactively, don't do anything
[ -z "$PS1" ] && return
source /etc/profile
export XDG_CONFIG_HOME=$HOME/.config
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histreedit
shopt -s histverify

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\033[01;31m\]\w\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[00m\]\$'

export LC_CTYPE=en_US.UTF-8

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export DYN_CHEF_DATA="${HOME}/gits/dyn_chef_data"
export SSL_CERT_FILE="${DYN_CHEF_DATA}/config/cacert.pem"
export DRIVER_PLUGIN="vagrant"
export PROVISIONER="chef_zero"
export PLATFORMS="ubuntu-1404"
export CHEF_VALIDATION_CLIENT_NAME=dschein
export CHEF_VALIDATION_KEY_PATH=$HOME/.chef/keys/dschein.pem
PATH=$PATH:${DYN_CHEF_DATA}/bin
PATH="$HOME/.rbenv/bin:$HOME/bin:$PATH"
export PATH

eval "$(rbenv init -)"

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

export WORKON_HOME=~/venv
source /usr/bin/virtualenvwrapper.sh
_virtualenvs()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "`ls $WORKON_HOME`" -- ${cur}) )
}

complete -o default -o nospace -F _virtualenvs workon
complete -o default -o nospace -F _virtualenvs rmvirtualenv

###des
#export GREP_OPTIONS='--binary-files=without-match --directories=skip --exclude=*.svn-base --exclude=*~'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
HISTSIZE=5000
HISTFILESIZE=5000

#CSCOPE_DB=~/cscope.out; export CSCOPE_DB

svndiff () {
    svn diff "${@}" | colordiff | less -R
}
hgdiff () {
    hg diff "${@}" | colordiff | less -R
}
export LESS='-FXRin'
export SRC='src/com/renesys/'
export EDITOR='/usr/bin/nvim'
export BROWSER=chromium

# To tell pip to only run if there is a virtualenv currently activated, and to bail if not, use:
export PIP_REQUIRE_VIRTUALENV=true
#. /home/davids/pyenv/pyl24/bin/activate

export CDPATH=::.:~:~/gits:~/3rd:

function act {
    source ~/pyenv/${1}/bin/activate
}

function tssh {
    ssh ${1}.psm1.renesys.com -t "ssh_auth_shuffle && tmux -u attach ${2}"
}

function tssh2 {
    ssh ${1}.psm1.renesys.com -t "ssh_auth_shuffle && tmux -u attach ${2} && tmux send-keys 'auth' "
}

function irc {
    ssh ssh.renesys.com -t 'tmux -u attach -d'
}

GPG_TTY=$(tty)
export GPG_TTY

set -o ignoreeof
#disable ctrl-d exit from shell
shopt -s dotglob
#    This one allows files beginning with a dot ('.') to be returned in the results of path-name expansion.
shopt -s extglob
#    This will give you ksh-88 egrep-style extended pattern matching or, in other words, turbo-charged pattern matching within bash. The available operators are:
#
#    ?(pattern-list)
#        Matches zero or one occurrence of the given patterns
#    *(pattern-list)
#        Matches zero or more occurrences of the given patterns
#    +(pattern-list)
#        Matches one or more occurrences of the given patterns
#    @(pattern-list)
#        Matches exactly one of the given patterns
#    !(pattern-list)
#        Matches anything except one of the given patterns

# set -o vi

set bell-style none
#setterm -blength 0

# default working project at the moment
#workon searchweb

export ACK_PAGER=less

function jshint-unused {
    jshint --show-non-errors ${1}
}

export NODE_PATH=/usr/lib/jsctags:\$NODE_PATH
export NODE_PATH=/usr/local/lib/jsctags/:\$NODE_PATH

eval `dircolors ~/.config/dircolors.ansi-universal`
# C-W to stop term output instead of C-S (so quick save works from VIM!)
#stty stop ^W #duh, but then you cannot switch windows in vim!

# ranger helpers
source /usr/share/doc/ranger/examples/bash_subshell_notice.sh
source /usr/share/doc/ranger/examples/bash_automatic_cd.sh

# git
. ~/git-completion.bash
. ~/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto git"
green='\[\033[0;32m\]'
reset_color='\[\033[0m\]'
#PROMPT_COMMAND='__git_ps1 "\h:\W \u\\\$ \n${VIRTUAL_ENV:+[$BLUE`basename $VIRTUAL_ENV`$COLOR_OFF]}"'
#PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$BLUE`basename $VIRTUAL_ENV`$COLOR_OFF]}" "@\h:\w\\\$ " "(%s)\n"'
#PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$BLUE`basename $VIRTUAL_ENV`$COLOR_OFF]}" "@\h:\w\\\$ " "(%s)\n"'
#PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$Yellow`basename $VIRTUAL_ENV`$COLOR_OFF]\n}" "\h:\W \u\\\$ " "[%s]\n"'
#PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$BLUE`basename $VIRTUAL_ENV`$COLOR_OFF] }" "\u@\h:${YELLOW}\w${COLOR_OFF}\n${GREEN}\\\$${COLOR_OFF} " "[%s] "'
PROMPT_COMMAND='__git_ps1 "${green}\w${reset_color} \u@\h ${VIRTUAL_ENV:+[`basename $VIRTUAL_ENV`] }" "\n${green}\\\$${reset_color} " "[%s] "'

#PROMPT_COMMAND='__git_ps1 "@\h:\w" "\\\$ "'


# vim: ai et sw=4 ts=4 sts=4:

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
