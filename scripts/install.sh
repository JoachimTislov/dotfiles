#!/usr/bin/env bash

folder_loc=$HOME/dotfiles

echo "Installing git and cloning dotfiles repository"
sudo pacman -S --noconfirm git
git clone --recurse-submodules https://github.com/JoachimTislov/dotfiles $folder_loc

echo "Setting desktop configurations (hyprland)"
sh $folder_loc/scripts/setup.sh
