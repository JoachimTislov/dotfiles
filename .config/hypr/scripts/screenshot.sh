#!/usr/bin/env bash

set -euo pipefail
mkdir -p "${SCREENSHOT_DIR:?SCREENSHOT_DIR is not set}"

name=$(rofi -dmenu -i -p "Filename" \
  -theme "$HOME/.config/hypr/conf/launcher.rasi" \
  -theme-str 'entry { placeholder: "Name this screenshot"; }' </dev/null)
[ -n "$name" ] || exit 0
name=$(printf '%s' "$name" | tr '/: ' '___' | tr -cd '[:alnum:]_.-')
[ -n "$name" ] || exit 0
case "$name" in *.png) ;; *) name="$name.png";; esac

file="$SCREENSHOT_DIR/$name"
slurp | grim -g - - | tee "$file" | wl-copy
