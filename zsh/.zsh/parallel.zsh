#!/usr/bin/env zsh

for p in $PACKAGES
do
    if [[ ! -a $p && ! -d "$MODULES_DIR/$p" ]];
    then
        mkdir -p "$MODULES_DIR/$p"
        git clone --quiet --depth 3 "git@github.com:$p"  "$MODULES_DIR/$p" &
    fi
done
date +'%s' > $MODULES_DIR/.updatetime
