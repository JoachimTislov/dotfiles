#!/usr/bin/env bash
set -e

dot=$HOME/dotfiles

echo "Configuring sddm"
sudo cp sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
sudo ln -s $dot/themes/sddm-astronaut-theme -t /usr/share/sddm/themes
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme] 
Current=sddm-astronaut-theme" > /etc/sdd.conf.d/sddm.conf
echo "[General]
InputMethod=qtvirtualkeyboard" > /etc/sddm.conf.d/virtualkbd.conf

source ./packages.sh

cd $dot

sudo pacman -Syu --noconfirm --needed ${packages[@]}

echo "Running stow"
stow .

echo "Applying darkmatter theme to grub"
cd themes/archlinux-grub
sudo python3 darkmatter-theme.py -i
cd $HOME

cp -r $dot/sddm /etc/sddm.conf.d/

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

