#!/usr/bin/env bash

packages=(
  ### yazi ###
  yazi
  file
  ffmpeg
  7zip
  jq
  poppler
  fd
  ripgrep
  fzf
  zoxide
  imagemagick
  ### nvim ###
  unzip
  make
  gcc
  neovim
  vim
  npm
  go
  ### hyprland ###
  hyprland
  hyprpaper
  hyprlock
  hypridle
  ttf-firacode-nerd
  kitty
  waybar
  mako
  pipewire
  wireplumber
  polkit-kde-agent
  rofi
  qt5-wayland
  qt6-wayland
  dolphin
  xdg-desktop-portal-hyprland
  sddm
  qt6-svg 
  qt6-virtualkeyboard
  qt6-multimedia-ffmpeg
  uwsm
  libnewt
  cliphist
  gtk4
  gtk3
  ### art ###
  fastfetch
  genact
  cava
  ### system monitor ###
  btop
  htop
  ### misc ###
  stow
  less
  eza
  brightnessctl
  wget
  lsb-release
  man-pages
  base-devel
  grub
  efibootmgr
  tmux
  firefox
  bitwarden
  discord
  zsh
  thefuck
  github-cli
  gimp
  ncspot
  docker
  spotify-launcher
  bluez-utils
)

user_packages=(
  waypaper
  matrix-git
  wlogout
  hollywood
  asciiquarium-transparent-git
  resvg
)

if lsblk -f | grep -e Windows -e ntfs > /dev/null; then
  packages+=(os-prober)
fi

# Nvidia gpu configuration - https://wiki.hypr.land/Nvidia/
if lspci | grep -i nvidia > /dev/null; then
  packages+=(
    nvidia-utils 
    nvidia
    egl-wayland
  )
  # Following isn't done for you ...
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
  echo "[spotify]
extra_arguments = ["--enable-features=UseOzonePlatform", "--ozone-platform=wayland"]" | sudo tee ~/.config/spotify-launcher.conf
fi
