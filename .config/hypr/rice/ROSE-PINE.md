# Rosé Pine desktop theme

Application configuration lives in its normal `.config/<application>` directory.
GTK 3 (Blueman) and GTK 4 (Pavucontrol) load the complete Rosepine-Dark theme,
including widget states and assets, rather than partial palette overrides.

Install the theme with `python ~/.config/hypr/scripts/install-rose-pine.py`.
Requires `curl`, `sassc`, and `bash`. The installer builds a pinned revision of
[Fausto-Korpsvart/Rose-Pine-GTK-Theme](https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme/tree/c4fdfa62a9eb6941a36b2cd5026fc64123aaa0dd)
and installs it into `~/.local/share/themes/Rosepine-Dark`.
Prior versions are saved under `~/.local/state/dotfiles/backups`.
Reopen applications after installation; log in again to refresh the UWSM environment.

Qt 6 uses `.config/qt6ct/colors/RosePine.conf`. Dolphin's existing color scheme
lives in `.local/share/color-schemes/VagueMacchiato.colors`.
Hyprland's active border and Waybar's Arch logo/active workspace use `#009fff`;
workspace hover stays green, as requested.

No universal theme switch covers custom-rendered applications. Electron,
Firefox, JetBrains, Qt Quick and terminal applications may require their own
Rosé Pine theme. Sandboxed applications may need access to the host theme;
no blanket Flatpak permissions are granted here.
