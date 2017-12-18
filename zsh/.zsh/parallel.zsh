#!/usr/bin/env zsh

for p in $PACKAGES
do
    if [[ ! -a $p ]];
    then
        mkdir -p "$MODULES_DIR/$p"
        git clone --depth 3 "https://github.com/$p"  "$MODULES_DIR/$p" &
    fi
done
