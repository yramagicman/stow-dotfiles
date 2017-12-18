#!/usr/bin/env zsh

for p in $PACKAGES
do
    if [[ ! -a $p ]];
    then
        mkdir -p "$HOME/ptest/$p"
        git clone --depth 3 "https://github.com/$p" "$HOME/ptest/$p" &
    fi
done
tree ptest
