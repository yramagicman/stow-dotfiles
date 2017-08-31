#!/bin/bash
#
# Sample .xinitrc for SuSE Linux
# This script is called from 'startx' when you start an X session
#

#
# In case everything goes wrong, we at least fall back to a plain xterm
#
failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

#
# Some bash (1 and 2) settings to avoid trouble on a
# failed program call.
#
set +e > /dev/null 2>&1
set +u > /dev/null 2>&1
set +o posix  > /dev/null 2>&1
if type shopt > /dev/null 2>&1 ; then
    shopt -s execfail
else
    no_exit_on_failed_exec=1
fi

#
# Source common code shared between the
# X session and X init scripts
#
. /etc/X11/xinit/xinitrc.common

#
# Special for twm
#
case "$WINDOWMANAGER" in
    *twm) xsetroot -solid darkslateblue
esac

#
# Uncomment next lines to activate asking for ssh passphrase
#
# if test -S "$SSH_AUTH_SOCK" -a -x "$SSH_ASKPASS"; then
#       ssh-add < /dev/null
# fi

#
# Add your own lines here...
#


# day planer deamon
# pland &

if test "$( hostname )" = "k-nine"
then
    # use natural scrolling
    xinput --set-prop 14 289 1
    # disable horizontal scrolling
    xinput --set-prop 14 304 0
    # more sensitive mouse
    xinput --set-prop 14 287 0.3
fi
setxkbmap -option compose:menu
setxkbmap -option caps:none
if stat $HOME/Gits/st/st > /dev/null; then
    export TERMINAL="$HOME/Gits/st/st"
elif which urxvt-256color > /dev/null; then
    export TERMINAL=urxvt-256color
elif which urxvt > /dev/null; then
    export TERMINAL=urxvt
elif which uxterm > /dev/null; then
    export TERMINAL=uxterm
else
    export TERMINAL=xterm
fi
export MAN_POSIXLY_CORRECT=true
#
# finally start the window manager
#
unset WINDOW_MANAGER STARTUP
exec $WINDOWMANAGER ${1+"$@"}

# call failsafe
exit 0
