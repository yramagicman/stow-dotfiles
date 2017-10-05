#!/usr/bin/env zsh

if ! type "stow" > /dev/null; then
    echo "Please install GNU Stow"
    return
fi

for f in $(find ./ -maxdepth 1 -type d | grep -Ev '.git$|config' | cut -d '/' -f 2 )
    stow -D $f -t ~/

stow -D config -t ~/.config
