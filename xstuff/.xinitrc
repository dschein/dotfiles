#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# or just $ xinit [wm]

DEFAULT_SESSION=i3
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
# urxvt daemon
urxvtd -q -f -o &

xset +fp /usr/share/fonts/local
xset fp rehash
xset -b
xset m 2.5 0
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# swap window (super) and alt key, make menu a super, and make capslock act like ctrl
# setxkbmap -option altwin:swap_lalt_lwin -option caps:ctrl_modifier -option altwin:alt_super_win

# this makes it so whenever the clipboard buffer is changed it also sets the selection buffer (but not the reverse)
autocutsel -fork &

envfile="${HOME}/.gnupg/gpg-agent.env"
if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
    eval $(cat "$envfile")
    eval $(cut -d= -f 1 < "$envfile" | xargs echo export)
else
    eval "$(gpg-agent --enable-ssh-support --daemon --write-env-file "$envfile")"
fi

# export BROWSER=chromium
# export http_proxy="127.0.0.1:8123"
# export no_proxy="localhost,127.0.0.1,.renesys.com,.psm1"



case $1 in
  i3)
    exec i3
    #exec i3 -V >> ~/.i3/i3log 2>&1
    ;;
  bspwm) 
    xbindkeys -f ~/.config/bspwm/xbindkeysrc
    exec bspwm
    ;;
  lxde)
    exec startlxde
    ;;
  qtile)
    wmname LG3D
    exec qtile
    ;;
  *)
    exec $DEFAULT_SESSION
    ;;
esac

