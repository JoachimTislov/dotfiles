#!/bin/bash

cd $HOME
sudo pacman -S --noconfirm --needed stow
stow .

# Install Yazi with all features
sudo pacman -S --noconfirm --needed file yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick

# Install Neovim and related packages
sudo pacman -S --noconfirm --needed unzip make gcc neovim vim npm go

# Hyprland desktop environment 
# Is here to supersede the archinstall later..
sudo pacman -S --noconfirm --needed hyprland kitty wofi qt5-wayland qtf6-wayland dunst dolphin xdg-deskstop-portal-hyprland sddm

sudo pacman -S --noconfirm --needed base-devel grub efibootmgr ttf-firacode-nerd fastfetch ly tmux firefox discord cava zsh thefuck github-cli gimp ncspot genact hollywood btop docker

# Install grub - bootloader
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# Apply darkmatter theme to grub
cd $HOME/dotfiles/darkmatter-grub2-theme
sudo python3 darkmatter-theme.py -i
cd $HOME

# Install oh my zsh
sh -c "$(wget -O- https://install.ohmyz.sh/)"

# Install vimrc - awesome
sh .vim_runtime/install_awesome_vimrc.sh

# Install yay
git clone https://aur.archlinux.org/yay.git
makepkg -D yay -si --noconfirm --needed
rm -rf yay

# Create cbonsai binary
git clone https://gitlab.com/jallbrit/cbonsai
cd cbonsai
make install PREFIX=/usr
cd .. && rm -rf cbonsai

yay -S --noconfirm spotify matrix-git asciiquarium-transparent-git resvg

