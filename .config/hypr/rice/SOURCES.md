# Visual setup and source credits

Extracted 2026-09-09 from [Omarchy, revision 5ead870](https://github.com/omacom/omarchy/tree/5ead870).
Only selected ideas and palette values were extracted into this directory; the
upstream source tree is not copied here. Omarchy's MIT license applies to its
source, while the links below identify the exact upstream material consulted.

| Component | Extracted source |
| --- | --- |
| All 22 bundled themes and backgrounds | [themes](https://github.com/omacom/omarchy/tree/5ead870/themes) |
| Shared application palette templates | [default/themed](https://github.com/omacom/omarchy/tree/5ead870/default/themed) |
| Bar, launcher, notifications, lock and other shell UI | [shell](https://github.com/omacom/omarchy/tree/5ead870/shell) |
| Window appearance and animations | [looknfeel.lua](https://github.com/omacom/omarchy/blob/5ead870/default/hypr/looknfeel.lua) |
| Application configs and shell layout | [config](https://github.com/omacom/omarchy/tree/5ead870/config) |
| Theme switching, wallpaper and desktop utilities | [bin](https://github.com/omacom/omarchy/tree/5ead870/bin) |
| Package and system setup references | [install](https://github.com/omacom/omarchy/tree/5ead870/install) and [default](https://github.com/omacom/omarchy/tree/5ead870/default) |
| Usage and customization documentation | [manual](https://github.com/omacom/omarchy/tree/5ead870/manual) |
| Focus existing app workflow | [omarchy-launch-or-focus](https://github.com/omacom/omarchy/blob/5ead870/bin/omarchy-launch-or-focus) |

The current Omarchy uses its own shell. Its shell and install scripts depend on
Omarchy services, paths and packages, so they are not drop-in Waybar/Rofi
replacements. The original Omarchy installation scripts are not used. GTK theme installation is described in ROSE-PINE.md.

## Adaptation to this machine

The launcher and screenshot prompt use the
[Rose Pine palette](https://rosepinetheme.com/palette/): base `#191724`, surface
`#1f1d2e`, overlay `#26233a`, text `#e0def4`, iris `#c4a7e7`, and foam `#9ccfd8`.
Omarchy's shared-palette approach informed the setup.
Hyprland's original window styling and Waybar corner radii are preserved.

- Rofi: `../conf/launcher.rasi`; Super+Shift+Return and Super+Ctrl+Return.
- Dolphin: `../../../.local/share/color-schemes/VagueMacchiato.colors`, the Qt6 palette in `../../qt6ct/colors/RosePine.conf`, Adwaita 12 and
  installed Breeze Dark icons. Fusion lets the palette control Qt widgets;
  changing qt6ct also affects other applications using that platform theme.
- Waybar: existing layout and radii with coordinated palette colors.
- Window focus: `../scripts/launch-or-focus.py` selects the most recently
  focused exact matching class, using desktop files' StartupWMClass where available.
  It never matches arbitrary window titles. Rofi and browser/file-manager shortcuts
  use it; unrelated external launchers are not intercepted. `focus_on_activate`
  also permits apps' own activation requests to focus existing windows.

The source archive includes upstream wallpaper assets; their individual authors'
rights and any asset-specific licensing continue to apply.
