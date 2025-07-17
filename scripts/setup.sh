#!/usr/bin/env bash
set -e

dot=~/dotfiles
conf="$dot/.config"
sddm=/usr/share/sddm
astro_theme="$sddm/themes/sddm-astronaut-theme"
cd "$dot"

source scripts/packages.sh

sudo pacman -Syu --noconfirm --needed ${packages[@]}

echo "Changing default shell to zsh"
chsh -s $(which zsh) # current user
sudo chsh -s $(which zsh) # root

echo "Configuring sddm"
sudo git clone https://github.com/Keyitdev/sddm-astronaut-theme.git "$astro_theme"
sudo cp -r "$astro_theme/Fonts/*" /usr/share/fonts/
sudo ln -s "$dot/sddm/sddm.conf" -t /etc
sudo sed -i 's|ConfigFile=Themes/.*|ConfigFile=Themes/cyberpunk.conf|' "$astro_theme/metadata.desktop"

# Adding Windows OS as an boot entry
if lsblk -f | grep -e Windows -e ntfs > /dev/null; then
  # Uncomment os-prober disable = false
  sudo sed -i 's/^#GRUB_DISABLE_OS_PROBER=/GRUB_DISABLE_OS_PROBER=/' /etc/default/grub
  update-grub # alias, view ~/.zshrc
fi

# Nvidia gpu configuration - https://wiki.hypr.land/Nvidia/
if lspci | grep -i nvidia > /dev/null; then
  sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
  echo '[spotify]
extra_arguments = ["--enable-features=UseOzonePlatform", "--ozone-platform=wayland"]' | sudo tee "$conf/spotify-launcher.conf"
  echo "env = LIBVA_DRIVER_NAME,nvidia
  env = __GLX_VENDOR_LIBRARY_NAME,nvidia
  env = ELECTRON_OZONE_PLATFORM_HINT,auto" >> "$conf/hypr/hyprland.conf"
fi

if [ "$(hostnamectl chassis)" = "desktop" ]; then
# IMPORTANT: The identifiers for MY monitors on the x11 server is DP-0 and DP-4, while for wayland its DP-1 and DP-3
# Place this cmd: "xrandr --listmonitors > $HOME/xrandr-log.txt" into $sddm/scripts/Xsetup to view what the identifiers are for the monitors on the x11 server, since it can differ from the ids on the wayland server.
echo "xrandr --output DP-4 --off" | sudo tee -a "$sddm/scripts/Xsetup"
else
  # Updating configuration accordingly for laptop...
  # I don't want to split into two branches... doing so would probably reduce complexity though
  # ... if you think sed is complex
  sed -i -E '/monitor = DP|workspace/ s/^/# /; /prefered/ s/^# *//' "$conf/hypr/hyprland.conf"
  sed -i 's/DP-1/eDP-1/' "$conf/hypr/hyprlock.conf" "$conf/waybar/config"
fi

echo "Running stow"
stow .

echo "Applying darkmatter theme to grub"
cd themes/archlinux-grub
sudo python3 darkmatter-theme.py -i
cd "$HOME"

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

