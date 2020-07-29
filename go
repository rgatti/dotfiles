#!/bin/sh
set -eu

if [ -z $(which stow 2>/dev/null) ]; then
    echo "Installing stow"
    if [ $(uname -s) == "Darwin" ]; then
        brew install stow
    else
        sudo apt-get install stow
    fi
fi

if ! [ -d ~/.dotfiles ]; then
    echo "Cloning dotfiles"
    git clone https://github.com/rgatti/dotfiles ~/.dotfiles
fi

echo "Touching default directories"
mkdir -p ~/src
mkdir -p ~/.config
mkdir -p ~/.local/share/nvim/site

echo "Linking dotfiles"
cd ~/.dotfiles
stow -v src

# vim :ts=4:sw=4:et
