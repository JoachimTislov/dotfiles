#!/usr/bin/env bash
set -euo pipefail

theme="$HOME/.config/hypr/conf/launcher.rasi"

cliphist list | rofi -dmenu -i -p 'Clipboard' -theme "$theme" | cliphist decode | wl-copy
