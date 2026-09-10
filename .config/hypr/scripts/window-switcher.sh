#!/usr/bin/env bash
set -euo pipefail

theme="$HOME/.config/hypr/conf/launcher.rasi"

for command in hyprctl jq rofi; do
    command -v "$command" >/dev/null 2>&1 || {
        notify-send 'Window switcher' "$command is not installed" 2>/dev/null || true
        exit 1
    }
done

clients=$(hyprctl clients -j 2>/dev/null) || {
    notify-send 'Window switcher' 'Hyprland is not available' 2>/dev/null || true
    exit 1
}
if ! jq -e 'type == "array"' >/dev/null 2>&1 <<<"$clients"; then
    notify-send 'Window switcher' 'Could not read Hyprland windows' 2>/dev/null || true
    exit 1
fi

windows=$(jq -c '
  map(select((.hidden // false) | not))
  | sort_by(.focusHistoryID)
  | map({ address, label: ((.class // "Window") + ": " + (.title // "Untitled")) })
' <<<"$clients")

labels=$(jq -r '.[].label' <<<"$windows")
selection=$(rofi -dmenu -i -no-custom -format i -p 'Windows' -theme "$theme" <<<"$labels") || exit 0

[[ "$selection" =~ ^[0-9]+$ ]] || exit 0
address=$(jq -r --argjson index "$selection" '.[$index].address' <<<"$windows")
[[ "$address" =~ ^0x[[:xdigit:]]+$ ]] || exit 0
if ! hyprctl dispatch focuswindow "address:$address" >/dev/null; then
    notify-send 'Window switcher' 'Could not focus the selected window' 2>/dev/null || true
    exit 1
fi
