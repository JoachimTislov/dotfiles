#!/usr/bin/env bash

source packages.sh

sudo pacman -Syu --noconfirm --needed ${pakages[@]}

echo "Running stow"
stow .

echo "Installing grub - bootloader"
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo "Applying darkmatter theme to grub"
cd darkmatter-grub2-theme
sudo python3 darkmatter-theme.py -i
cd $HOME

# Install oh my zsh and plugins 
sh -c "$(wget -O- https://install.ohmyz.sh/)"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH/custom/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/autosuggestions

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

