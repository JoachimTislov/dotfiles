#!/usr/bin/env bash
set -e

dot=$HOME/dotfiles
cd $dot

source scripts/packages.sh

sudo pacman -Syu --noconfirm --needed ${packages[@]}

echo "Changing default shell to zsh"
chsh -s $(which zsh) # current user
sudo chsh -s $(which zsh) # root

echo "Configuring sddm"
sudo git clone https://github.com/Keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
if ! sudo stat /etc/sddm.conf.d > /dev/null; then
  sudo mkdir /etc/sddm.conf.d
fi
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf.d/sddm.conf
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf

echo "Running stow"
stow .

echo "Applying darkmatter theme to grub"
cd themes/archlinux-grub
sudo python3 darkmatter-theme.py -i
cd $HOME

echo "Building cbonsai binary from source"
git clone https://gitlab.com/jallbrit/cbonsai
cd cbonsai
sudo make install PREFIX=/usr
cd .. && rm -rf cbonsai

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
makepkg -D yay -si --noconfirm --needed
rm -rf yay

echo "Installing user packages"
yay -S --noconfirm ${user_packages[@]} 

