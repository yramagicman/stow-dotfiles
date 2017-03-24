#!/usr/bin/env zsh

if ! type "stow" > /dev/null; then
    echo "Please install GNU Stow"
    return
fi

for f in $(find ./ -maxdepth 1 -type d | grep -Ev '.git|config' | cut -d '/' -f 2 )
    stow -Rv $f -t ~/

stow -Rv config -t ~/.config


split=("${(@s#/#)SHELL}")
shell=$split[-1]
if [[ $shell != 'zsh' ]]; then
    chsh -s $(which zsh)
fi
source ~/.zshrc
