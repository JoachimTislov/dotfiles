#!/bin/bash
# __  ______   ____
# \ \/ /  _ \ / ___|
#  \  /| | | | |  _
#  /  \| |_| | |_| |
# /_/\_\____/ \____|
#

killall -e xdg-desktop-portal-hyprland xdg-desktop-portal

# Set required environment variables
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

services=(
  pipewire 
  wireplumber 
  xdg-desktop-portal 
  xdg-desktop-portal-hyprland
)

systemctl --user stop "${services[@]}"
systemctl --user start "${services[@]}"
