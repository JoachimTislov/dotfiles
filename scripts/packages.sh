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
  cliphist
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
  sed
  eza
  brightnessctl
  wget
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
)

user_packages=(
  spotify
  matrix-git
  wlogout
  hollywood
  asciiquarium-transparent-git
  resvg
)

if lsblk -f | grep -e Windows -e ntfs > /dev/null; then
  packages+=(os-prober)
fi

if lspci | grep -i nvidia > /dev/null; then
  packages+=(
    nvidia-utils 
    egl-wayland
  )
fi
