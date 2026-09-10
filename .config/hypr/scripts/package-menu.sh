#!/usr/bin/env bash
set -euo pipefail

theme="$HOME/.config/hypr/conf/launcher.rasi"
menu() {
    local prompt="$1"
    shift
    rofi -dmenu -i -p "$prompt" -theme "$theme" "$@"
}

action=$(printf '%s\n' \
    'Install package' \
    'Remove package' \
    'Search packages' \
    'Upgrade system' \
    'List installed' \
    'Remove orphans' | menu 'Packages')

valid_package() {
    [[ "$1" =~ ^[[:alnum:]@._+:-]+$ ]]
}

run_pacman() {
    kitty --title "pacman" -e sudo pacman "$@"
}

case "$action" in
    'Install package')
        package=$(menu 'Install') || exit 0
        valid_package "$package" || exit 0
        run_pacman -S --needed -- "$package"
        ;;
    'Remove package')
        package=$(pacman -Qq | menu 'Remove') || exit 0
        valid_package "$package" || exit 0
        run_pacman -Rns -- "$package"
        ;;
    'Search packages')
        query=$(menu 'Search') || exit 0
        [ -n "$query" ] || exit 0
        pacman -Ss "$query" | menu 'Results' >/dev/null || true
        ;;
    'Upgrade system')
        run_pacman -Syu
        ;;
    'List installed')
        pacman -Q | menu 'Installed' >/dev/null || true
        ;;
    'Remove orphans')
        mapfile -t orphans < <(pacman -Qdtq)
        ((${#orphans[@]})) || exit 0
        confirm=$(printf 'Remove %d orphan packages\nCancel\n' "${#orphans[@]}" | menu 'Orphans')
        [[ "$confirm" == Remove* ]] || exit 0
        run_pacman -Rns --asdeps -- "${orphans[@]}"
        ;;
esac
