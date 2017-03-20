#!/usr/bin/env sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/php
brew tap homebrew/dupes
brew install vim zsh tmux mutt php54 python ruby tmux reattach-to-user-namespace git node cmus bash pass ack lynx pandoc tree tig sl pwgen htop nmap iftop drush wget ctags-exuberant
brew install macvim --override-system-vim
brew linkapps
gem install sass compass
npm install -g npm@latest
npm install yo grunt-cli jshint
