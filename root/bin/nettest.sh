#!/bin/zsh
echo "Checking internet connectivity..."
ping -c 5 www.google.com>>/dev/null

if [ $? -eq  0 ]
    then
curl -L https://raw.github.com/yramagicman/zsh-aliases/master/plugins/aliases/aliases.plugin.zsh | zsh
    else
    echo "Not able to check internet connectivity!"
fi
