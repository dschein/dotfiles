alias sudo='sudo ';
alias cd..='cd ..'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ctun='ssh -L 8667:localhost:6667 -N irc01.fd.ord1.renesys.com & ssh -L 8389:localhost:389 -N irc01.fd.ord1.renesys.com &'
alias dbtun='ssh -f -L 5432:localhost:5432 -N webdev02.psm1'
alias ducks='du -cks * | sort -rn | head -11'
alias :e='nvim'
alias ed='nvim'
alias gvimr='gvim --remote '
alias gitup='find -mindepth 1 -maxdepth 1 -type d | xargs -L1 ./gitup.cmd'
alias iflo='sudo ifconfig lo:0 127.0.0.2'
alias run='python manage.py runserver'
alias t='ctags -R; find . -name "*.java" -o -name "*.py" -o -name "*.pl" -o -name "*.pm" | cscope -Rb -i-'
alias unctun='pkill -f "ssh -L 8667" && pkill -f "ssh -L 8389"'
alias undbtun='pkill -f "ssh -L 5432"'
alias two-screens-l='xrandr --output VGA1 --primary --auto --left-of LVDS1 --output LVDS1 --auto'
alias two-screens-r='xrandr --output VGA1 --primary --auto --right-of LVDS1 --output LVDS1 --auto'
alias two-screens-top='xrandr --output VGA1 --primary --auto --above LVDS1 --output LVDS1 --auto'
alias one-screen='xrandr --output LVDS1 --primary --auto --output VGA1 --off'
alias one-screen-big='xrandr --output VGA1 --primary --auto --output LVDS1 --off'
alias clone-screens='xrandr --output LVDS1 --primary --auto --output VGA1 --auto --same-as LVDS1'
alias mountcd='sudo  mount -t iso9660 -o ro /dev/cd/cdrom-0\:0\:0\:0 ./cd'
alias unmountcd='sudo umount /dev/cd/cdrom-0\:0\:0\:0 && sudo eject'
alias vpnstart='sudo openvpn --config ~davids/.openvpn/dyn.conf'
alias vpnstart-renesys='sudo openvpn --config ~davids/.openvpn/renesys.conf'
alias vpnstop='sudo pkill openvpn'
alias cleardyn='sudo pdnsd-ctl empty-cache renesys.com .psm1 .mai1 dyn.com dyndns.com dynect.com && sudo pdnsd-ctl config'
# sudo pdnsd-ctl server renesys retest
alias p='pushd'
alias o='popd'
alias mountsd='sudo mount -t vfat -o defaults,rw,umask=0 /dev/mmcblk0p1 /media'
alias unmountsd='sudo umount /dev/mmcblk0p1'
alias mouse='xset mouse 5 1'
alias git?='man gitglossary'
alias diff='colordiff'
alias backup='rsync -av --delete .git davids-vh.psm1:~/backups/laptop/$( basename $( pwd ) )/'
alias vimbaks='find . -name "*~" -o -name "*.swp"'
alias ctrl='xmodmap ~/.xmodmap'
alias touchpadoff='synclient TouchPadOff=1'
alias touchpadon='synclient TouchPadOff=0'
alias jsonpretty='/usr/bin/python2 -m"json.tool"'
alias redshifton='redshift-gtk -l42.340382:-72.496819 &'
#altwin:swap_alt_win
alias keyboardlap=' xset -b ; killall xbindkeys ; xbindkeys ; setxkbmap -option altwin:swap_alt_win,shift:both_capslock,caps:ctrl_modifier,altwin:alt_super_win ; '
alias keyboardcode='xset -b ; killall xbindkeys ; xbindkeys ; setxkbmap -option altwin:swap_alt_win,shift:both_capslock ; '
alias vh='tssh davids-vh'
alias w1='tssh webdev01'
alias w2='tssh webdev02'
alias d1='tssh dev01'
alias d2='tssh dev02'
alias d3='tssh dev03'
alias d4='tssh dev04'
alias d4='tssh dev04'
alias d6='tssh dev06'
alias d9='tssh dev09'
alias d11='tssh dev11'
alias d13='tssh dev13'
alias o11='tssh ops11'
alias prodlogs='tssh loghost'
alias jenkins='ssh jenkins-dev-vh.psm1.renesys.com'
alias keycode="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias servehere='python -m SimpleHTTPServer 8889'
alias eventsblog-prod-log='ssh cook04.mia1.renesys.com "tai64nlocal < /service/eventsblog-entry/log/main/current" | less'
alias clipboard='echo -e "\E[30mselection:\E[31m\n$( xclip -o )\E[30m\n\nclipboard:\E[32m\n$( xclip -o -selection clipboard )\E[37m"'
alias bc='bc -l'

# dryrun: find ./ -type f -exec sed --quiet 's/string1/string2/gp' {} \;
# do it!: find ./ -type f -exec sed -i 's/string1/string2/g' {} \;

alias cp='cp -v --interactive'
alias mv='mv -v --interactive'
alias rm='rm -v --interactive=once'

alias pe='ps -eFlT'
alias px='ps aux'
alias nst='netstat --all --tcp --udp --numeric'
alias maxim-map='setxkbmap -option -option caps:ctrl_modifier -option altwin:alt_super_win'
alias vnc-serve='x11vnc'
alias i3-twoscreens='for i in {1..9}; do i3-msg workspace $i && i3-msg move workspace to output VGA1; done'
alias updatemirrorlist='sudo reflector --verbose --country "United States" --country Canada -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
alias screenshot='shutter'
alias camera='guvcview'
alias kace='sudo /opt/dell/kace/bin/AMPAgent --daemon && sudo /opt/dell/kace/bin/AMPTools get host && ps aux | grep [A]MPAgent'

# dircolors... make sure that we have a color terminal, dircolors exists, and ls supports it.
if $TERM_IS_COLOR && ( dircolors --help && ls --color ) &> /dev/null; then
  # For some reason, the unixs machines need me to use $HOME instead of ~
  # List files from highest priority to lowest.  As soon as the loop finds one that works, it will exit.
  for POSSIBLE_DIR_COLORS in "$HOME/.dir_colors" "/etc/DIR_COLORS"; do
    [[ -f "$POSSIBLE_DIR_COLORS" ]] && [[ -r "$POSSIBLE_DIR_COLORS" ]] && eval `dircolors -b "$POSSIBLE_DIR_COLORS"` && break
  done

  alias ls="ls --color=auto"
  alias ldot="ls --color=auto -d .*"
  alias ll="ls -h --color=auto -l"
  alias la="ls --color=auto -a"
  alias l="ls --color=auto -C"
  #alias grep='grep --binary-files=without-match --directories=skip --exclude=*.svn-base --exclude=*~ --color=auto'
  alias la='ls -A'
else
  # No color, so put a slash at the end of directory names, etc. to differentiate.
  alias ls="ls -F"
  alias l="ls -CF"
  alias la="l -aF"
  alias ll="ls -lF"
  alias ldot="ls -dF .*"
  alias grep='grep --binary-files=without-match --directories=skip --exclude=*.svn-base --exclude=*~'
fi

alias tigs='tig status'
