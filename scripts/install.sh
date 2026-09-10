#!/usr/bin/env bash
set -Eeuo pipefail

folder_loc="$HOME/dotfiles"
if [[ -e "$folder_loc" ]]; then
  if [[ -d "$folder_loc/.git" ]]; then
    echo "Dotfiles checkout already exists; rerunning setup."
    bash "$folder_loc/scripts/setup.sh"
    exit $?
  fi
  echo "Destination already exists and is not a dotfiles checkout: $folder_loc" >&2
  exit 1
fi

echo "Installing git and cloning dotfiles repository"
sudo pacman -S --needed git
git clone --recurse-submodules https://github.com/JoachimTislov/dotfiles "$folder_loc"

# TODO: use reflector and configure a manual installation

echo "Setting desktop configurations (hyprland)"
bash "$folder_loc/scripts/setup.sh"
