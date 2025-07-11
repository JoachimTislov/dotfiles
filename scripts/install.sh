#!/usr/bin/env bash

folder_loc=$HOME/dotfiles

echo "Installing git and cloning dotfiles repository"
sudo pacman -S --noconfirm git
git clone https://github.com/JoachimTislov/dotfiles $folder_loc
cd $folder_loc
git submodule update --init --remote --recursive

echo "Setting desktop configurations (hyprland)"
# setup.sh should only be called inside the dotfiles directory
sh setup.sh
