# Hyprland configuration

Edit `hyprland.lua` or the modules in `conf/*.lua`. Hyprland watches these
files and reloads automatically when they are saved.

Check the running session with `hyprctl configerrors`.

The previous Hyprland configuration is archived under `legacy/` and is not
loaded. To restore it, copy `legacy/hyprland.conf` and `legacy/conf/*.conf`
back to their original locations and explicitly launch Hyprland with
`--config ~/.config/hypr/hyprland.conf`.

`hypridle.conf`, `hyprlock.conf`, and `hyprpaper.conf` configure separate
programs and still use their original format.
