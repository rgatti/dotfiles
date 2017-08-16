This is my personal collection of dotfiles. I use gnu stow to manage
symlinks in my home dir. Since most distros create a bunch of default
files I have a simple `init` script to help on first setup.

Requirements: git stow

    sudo apt install -y git stow

Install:
	1. git clone git@github.com:rgatti/dotfiles.git ~/.ssh
	2. cd ~/.dotfiles
	3. ./init [package] (ex. ./init bash)

Update:
    1. cd ~/.dotfiles
    2. stow [package] (ex. stow bash)
