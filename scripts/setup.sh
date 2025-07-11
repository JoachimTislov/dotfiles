#!/usr/bin/env bash
set -e

source ./packages.sh

cd $HOME/dotfiles 

sudo pacman -Syu --noconfirm --needed ${packages[@]}

echo "Running stow"
stow .

echo "Applying darkmatter theme to grub"
cd archlinux-grub-theme
sudo python3 darkmatter-theme.py -i
cd $HOME

cp -r $HOME/dotfiles/sddm /etc/sddm.conf.d/

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
makepkg -D yay -si --noconfirm --needed
rm -rf yay

echo "Installing cbonsai"
git clone https://gitlab.com/jallbrit/cbonsai
cd cbonsai
make install PREFIX=/usr
cd .. && rm -rf cbonsai

echo "Installing user packages"
yay -S --noconfirm ${user_packages[@]} 

# Install oh my zsh and plugins 
sh -c "$(wget -O- https://install.ohmyz.sh/)"
# TODO: Find a way of installing ohmyzsh with following plugins 
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH/custom/plugins/fast-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/autosuggestions

