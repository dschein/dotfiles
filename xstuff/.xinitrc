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
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# swap window (super) and alt key, make menu a super, and make capslock act like ctrl
# setxkbmap -option altwin:swap_lalt_lwin -option caps:ctrl_modifier -option altwin:alt_super_win

# this makes it so whenever the clipboard buffer is changed it also sets the selection buffer (but not the reverse)
autocutsel -fork &

case $1 in
  i3)
    exec i3
    #exec i3 -V >> ~/.i3/i3log 2>&1
    ;;
  lxde)
    exec startlxde
    ;;
  *)
    exec $DEFAULT_SESSION
    ;;
esac

