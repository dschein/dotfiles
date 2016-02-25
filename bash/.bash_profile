#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export LANG=en_US.UTF-8

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
# # Set SSH to use gpg-agent
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
# fi

# # Set GPG TTY
# GPG_TTY=$(tty)
# export GPG_TTY

# # Refresh gpg-agent tty in case user switches into an X session
# gpg-connect-agent updatestartuptty /bye >/dev/null

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
