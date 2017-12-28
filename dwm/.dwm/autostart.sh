#!/bin/sh
xbacklight -set 25
check_process(){

    if  ! pgrep "$1";
    then
        $1 &
    fi

}

( /home/jonathan/.screenlayout/default.sh) &
( nitrogen --restore) &

"$HOME/bin/i3st" &
# xsetroot -solid '#082F4E'

xset -dpms; xset s off &
(sleep 1s && check_process compton -c) &
(sleep 1s && /usr/bin/xscreensaver -no-splash) &
(sleep 10s && xfce4-power-manager) &
(sleep 5s  && "$HOME/bin/get_remote_ip") &

## Set keyboard settings - 250 ms delay and 25 cps (characters per
## second) repeat rate.  Adjust the values according to your
## preferances.
xset r rate 250 25 &

pulseaudio --start
## Turn on/off system beep
xset b off &

# Autostart the Dropbox deamon, but not on my laptop.
(sleep 10s && dropbox start) &

# Update weather info on boot
(sleep 45s && check_process redshift) &

#limit the size of dirs history
d=$(sort -u  "$HOME/.cache/zsh/dirs" )
rm "$HOME/.cache/zsh/dirs"
echo "$d" > "$HOME/.cache/zsh/dirs"

h=$(sort -u  "$HOME/.surf/history.txt" )
rm "$HOME/.surf/history.txt"
echo "$h" > "$HOME/.surf/history.txt"
# make sure tmux digests file isn't overly large
z=$(tail  "$HOME/.tmux.d/digests" -n "$(find  "$HOME/.tmux.d/" | wc -l)" )
rm "$HOME/.tmux.d/digests"
echo "$z" > "$HOME/.tmux.d/digests"

echo "" > "$HOME/.xsession-errors"
if ! stat "$HOME/.xsession-errors.old" > /dev/null; then
    rm "$HOME/.xsession-errors.old"
fi
if ! stat "$HOME/Gits/st/st" > /dev/null; then
    notify-send -u critical "st not intsalled in $HOME/Gits/st"
fi


if  stat "$HOME/.config/new_mail" > /dev/null; then
    rm "$HOME/.config/new_mail"
fi
if test "$( hostname )" = 'k-nine'; then
    if nmcli | grep 'hide_yo_kids'; then
        "$HOME/bin/get_remote_ip"
    fi

    if ! grep "$(cat "$HOME/.config/rip")" /etc/sysconfig/proxy; then
        notify-send -u critical "Remote IP and Proxy URL are different"
    fi
fi
fetchmail &
echo '' > "$HOME/.config/fetchmail.log"
echo '' > "$HOME/.config/procmail.log"
echo '' > "$HOME/.config/msmtp.log"
echo '' > "$HOME/.mpd/mpdstate"

zypper pa -i | grep 'openSUSE' | cut -d '|' -f 3 | sort -u > bin/setup/default_repos

zypper pa -i | grep 'packman' | cut -d '|' -f 3 | sort -u > bin/setup/packman

zypper pa -i | grep 'dvd' | cut -d '|' -f 3 | sort -u > bin/setup/dvd

exit

