# JoachimTislov's dotfiles

These are the files I use for my arch linux setup. I have mostly taken insperation from the [unixporn](https://reddit.com/r/unixporn/), [archlinux](https://reddit.com/r/archlinux/), [Hyprland](https://www.reddit.com/r/hyprland/) and [neovim](https://www.reddit.com/r/neovim/) Reddit communities.

Use at your own risk!

## Packages overview

[View here](./packages-description.md)

## Thanks to..

- dotfiles
    - [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
    - [MrVivekRajan](https://github.com/MrVivekRajan/Hypr-Dots)
    - [shreyas-sha3](https://github.com/shreyas-sha3/niri-dotsd)
    - [deathbeam](https://github.com/deathbeam/dotfiles)
    - [BrodieRobertson](https://github.com/BrodieRobertson/dotfiles)
- configurations
    - [hayyaoe - Zenties (Hyprland setup)](https://github.com/hayyaoe/zenities)
    - [LierB - fastfetch](https://github.com/LierB/fastfetch)
    - [Mylinuxforwork](https://github.com/mylinuxforwork)
    - [amix - vimrc](https://github.com/amix/vimrc)
- themes
    - [VandalByte's darkmatter theme for GRUB](https://github.com/VandalByte/darkmatter-grub2-theme)
    - [Catppuccin](https://github.com/catppuccin)
        - [cava](https://github.com/catppuccin/cava)
        - [ncspot](https://github.com/catppuccin/ncspot)
    - [Keyitdev - sddm](https://github.com/Keyitdev/sddm-astronaut-theme)
    - [Nordtheme](https://nordtheme.com/)
    - [Rosè Pine](https://github.com/rose-pine)
- wallpapers
    - [dharmx - walls](https://github.com/dharmx/walls)
    - [leroiduflow - Wallsync](https://github.com/leroiduflow/WallSync)
- scripts
    - [BreadOnPenguins](https://github.com/BreadOnPenguins/scripts)
    - [suckless - dmenu](https://suckless.org/dmenu/scripts)
- [Brodie Robertson - Enable and use vi in your shell](https://youtube.com/watch?v=hIJh-KlQ7io)
... and many more!

## Useful resources

List of resources I found helpful for understanding and configuring [Arch linux](https://archlinux.org/)

- Archlinux [wiki](https://wiki.archlinux.org/title/Main_page) and [forums](https://bbs.archlinux.org/)
- [Garuda Linux Forum](https://forum.garudalinux.org/)
- [Slackware pkgblog - coreutils](https://ratfactor.com/slackware/pkgblog/coreutils)
- [Bash cheat sheet](https://github.com/RehanSaeed/Bash-Cheat-Sheet)
- [Alexays - Waybar](https://github.com/Alexays/Waybar)
- [Brodie Robertson - Youtube](https://youtube.com/@BrodieRobertson)
- [Hyprland community - Awesome list of tools and libraries](https://github.com/hyprland-community/awesome-hyprland#custom-isos)
- [Hyprland contrib](https://github.com/hyprwm/contrib)
- Subreddits
    - [Archlinux](https://reddit.com/r/archlinux/)
    - [Unixporn](https://reddit.com/r/unixporn/)
    - [Linux](https://reddit.com/r/linux/)
    - [Hyprland](https://reddit.com/r/hyprland/)
    - [Neovim](https://reddit.com/r/neovim/)

## TODOs

- setup [youtube tui](https://github.com/Siriusmart/youtube-tui)
- Add more keybindings, connect to bluetooth ...
- wall papers
- Waybar modules
    - day to date
    - cpu temp
    - memory usage
    - name of music playing and app
    - disk space
- Create a rofi launcher list with all the open apps, go to window on selection
- Get familiar with wf-recorder pkg
- Setup [btrfs](https://wiki.archlinux.org/title/Btrfs) - Look at Snapper (pacman hooks) or timeshift...
- Write command for partionining the disk (swap) to enable `systemctl hibernate` (hibernation)
- Remove yazi ?
- Remove noice: "Fontconfig warning: using without calling FcInit()"
    - ? where

## Archive of old TODOs - completed or not so relevant anymore

- Configure [app2](https://github.com/Vladimir-csp/app2unit) for uwsm or setup rest of the uwsm cmds
    - app2 has better performance than uwsm, but thats not needed for my usecase
- Waybar: figure out how to reverse the hyprland workspaces module
    - use property "sort-by" ...
    - https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#sort
