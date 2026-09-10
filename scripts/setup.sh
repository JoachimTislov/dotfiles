#!/usr/bin/env bash
set -Eeuo pipefail

dot=~/dotfiles
conf="$dot/.config"
sddm=/usr/share/sddm
astro_theme="$sddm/themes/sddm-astronaut-theme"
cd "$dot"

source scripts/packages.sh

sudo pacman -Syu --noconfirm --needed "${packages[@]}"

echo "Changing default shell to zsh"
zsh_path=$(command -v zsh)
chsh -s "$zsh_path"      # current user

echo "Installing copilot CLI extension for the GitHub CLI"
if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi
if ! gh extension list | grep -q 'gh-copilot'; then
  gh extension install github/gh-copilot
fi

echo "Cloning tmux plugin manager"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "Linking tmux-sessionizer script to /usr/bin/stmux"
sudo ln -sfn "$HOME/dotfiles/scripts/tmux-sessionizer.sh" /usr/bin/stmux

echo "Configuring sddm"
if [[ ! -d "$astro_theme" ]]; then
  sudo git clone https://github.com/Keyitdev/sddm-astronaut-theme.git "$astro_theme"
fi
sudo cp -r "$astro_theme/Fonts/"* /usr/share/fonts/
sudo ln -sfn "$dot/sddm/sddm.conf" /etc/sddm.conf
sudo sed -i 's|ConfigFile=Themes/.*|ConfigFile=Themes/cyberpunk.conf|' "$astro_theme/metadata.desktop"

# Adding Windows OS as an boot entry
if lsblk -f | grep -e Windows -e ntfs >/dev/null; then
  # Uncomment "os-prober disable = false"
  sudo sed -i 's/^#GRUB_DISABLE_OS_PROBER=/GRUB_DISABLE_OS_PROBER=/' /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Nvidia gpu configuration - https://wiki.hypr.land/Nvidia/
if lspci | grep -i nvidia >/dev/null; then
  sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
  echo '[spotify]
extra_arguments = ["--enable-features=UseOzonePlatform", "--ozone-platform=wayland"]' | sudo tee "$conf/spotify-launcher.conf"
fi

if [ "$(hostnamectl chassis)" = "desktop" ]; then
  # IMPORTANT: The identifiers for MY monitors on the x11 server is DP-0 and DP-4, while for wayland its DP-1 and DP-3
  # Place this cmd: "xrandr --listmonitors > $HOME/xrandr-log.txt" into $sddm/scripts/Xsetup to view what the identifiers are for the monitors on the x11 server, since it can differ from the ids on the wayland server.
  if ! sudo grep -Fxq 'xrandr --output DP-4 --off' "$sddm/scripts/Xsetup"; then
    echo "xrandr --output DP-4 --off" | sudo tee -a "$sddm/scripts/Xsetup" >/dev/null
  fi
else
  for file in "$conf/hypr/hyprlock.conf" "$conf/waybar/config"; do
    [[ -f "$file" ]] && sed -i 's/DP-1/eDP-1/g' "$file"
  done
fi

echo "Running stow"
# Adopt existing user files once, then maintain the checkout as the source of
# truth on subsequent runs. This makes reruns safe after a partial installation.
stow --adopt --restow .

echo "Applying darkmatter theme to grub"
cd themes/archlinux-grub
sudo python3 darkmatter-theme.py -i
cd "$HOME"

echo "Building cbonsai binary from source"
if [[ ! -d "$HOME/cbonsai" ]]; then
  git clone https://gitlab.com/jallbrit/cbonsai "$HOME/cbonsai"
fi
cd cbonsai
sudo make install PREFIX=/usr
cd "$dot"

echo "Installing yay"
if ! command -v yay >/dev/null 2>&1; then
  yay_dir=$(mktemp -d)
  trap 'rm -rf "$yay_dir"' EXIT
  git clone https://aur.archlinux.org/yay.git "$yay_dir/yay"
  makepkg -D "$yay_dir/yay" -si --noconfirm --needed
  rm -rf "$yay_dir"
  trap - EXIT
fi

echo "Installing user packages"
yay -S --noconfirm --needed "${user_packages[@]}"
