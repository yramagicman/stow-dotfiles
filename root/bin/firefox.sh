#!/usr/bin/zsh

if [[ -a $HOME/bin/firefox/firefox ]]; then
    $HOME/bin/firefox/firefox $@
else
    firefox $@
fi
