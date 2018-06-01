#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


if test "$( hostname )" = "k-nine" || test "$( hostname )" = "serenity"
then
    $HOME/bin/setmouse &
fi
setxkbmap -option compose:menu
setxkbmap -option caps:none
if stat $HOME/Gits/st/st 2>&1 > /dev/null; then
    export TERMINAL="$HOME/Gits/st/st"
elif which st > /dev/null; then
    export TERMINAL=st
elif which urxvt-256color > /dev/null; then
    export TERMINAL=urxvt-256color
elif which urxvt > /dev/null; then
    export TERMINAL=urxvt
elif which uxterm > /dev/null; then
    export TERMINAL=uxterm
else
    export TERMINAL=xterm
fi

exec $HOME/bin/dwmrestart
