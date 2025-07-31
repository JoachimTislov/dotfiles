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
  kitty
  waybar
  mako
  pipewire
  wireplumber
  hyprpolkitagent
  rofi
  qt5-wayland
  qt6-wayland
  qt6ct
  dolphin
  ark
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  sddm
  qt6-svg
  qt6-virtualkeyboard
  qt6-multimedia-ffmpeg
  uwsm
  libnewt
  cliphist
  gtk4
  gtk3
  ### fonts ###
  ttf-firacode-nerd
  ttf-font-awesome
  noto-fonts-emoji
  ### art ###
  fastfetch
  genact
  cava
  ### system monitor ###
  btop
  htop
  mission-center
  ### misc ###
  stow
  less
  eza
  brightnessctl
  wget
  lsb-release
  man-pages
  base-devel
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
  bluez
  blueman
  usbutils
  speedtest-cli
  ripgrep
)

user_packages=(
  waypaper
  adwaita-dark
  cmatrix-git
  wlogout
  hollywood
  asciiquarium-transparent-git
  resvg
  nordzy-cursors
)

if lsblk -f | grep -e Windows -e ntfs >/dev/null; then
  packages+=(os-prober)
fi

if [ "$(hostnamectl chassis)" = "desktop"]; then
  packages+=(
    xorg-xrandr
    xorg-xrdb
    linux-firmware-realtek # for bluetooth
  )
else
  packages+=(
    power-profiles-daemon
  )
fi

# Nvidia gpu configuration - https://wiki.hypr.land/Nvidia/
if lspci | grep -i nvidia >/dev/null; then
  packages+=(
    nvidia-utils
    nvidia-settings
    nvidia
    egl-wayland
  )
fi
