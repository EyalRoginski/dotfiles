#! /usr/bin/bash

copy () {
    if [ -f $1 ]
    then
        cp -R $1 .
    else
        echo $1 "not found."
    fi
}

copy ~/.tmux.conf
copy ~/.zshrc
copy ~/.aliases
copy ~/.p10k.zsh

if [ -d ~/.config/nvim/ ]
then
    mkdir -p ./.config/nvim
    cp -R ~/.config/nvim ./.config/
else
    echo "~/.config/nvim/ not found."
fi
