#!/usr/bin/env bash
set -Eeuo pipefail

folder_loc="$HOME/dotfiles"
if [[ -e "$folder_loc" ]]; then
  if [[ -d "$folder_loc/.git" ]]; then
    echo "Arch configuration checkout already exists; rerunning setup."
    bash "$folder_loc/scripts/setup.sh"
    exit $?
  fi
  echo "Destination already exists and is not an arch configuration checkout: $folder_loc" >&2
  exit 1
fi

echo "Installing git and cloning the arch configuration repository"
sudo pacman -S --needed git
git clone --recurse-submodules https://github.com/JoachimTislov/arch "$folder_loc"

# TODO: use reflector and configure a manual installation

echo "Setting desktop configurations (hyprland)"
bash "$folder_loc/scripts/setup.sh"
