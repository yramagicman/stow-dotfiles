#!/usr/bin/env zsh
cd $HOME
rm -rvf $HOME/.zprezto
git clone --recursive https://github.com/yramagicman/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
cd $HOME/.zprezto
git remote add upstream https://github.com/zsh-users/prezto/
cd
ln -s ~/.zprezto/modules/zsh-aliases/prompt_lime_setup ~/.zprezto/modules/prompt/functions/prompt_lime_setup

sed  -i 's#https://github.com/yramagicman/prezto.git#git@github.com:yramagicman/prezto.git#' ~/.zprezto/.git/config
