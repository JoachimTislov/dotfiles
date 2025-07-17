# JoachimTislov's dotfiles

These are the files I use for my arch linux setup. I have mostly taken insperation from the [unixporn](https://reddit.com/r/unixporn/) and [archlinux](https://reddit.com/r/archlinux/) Reddit communities.

Use at your own risk!

## Packages overview 

[View here](./packages-description.md)

## Thanks to..

- dotfiles
    - [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
    - [MrVivekRajan](https://github.com/MrVivekRajan/Hypr-Dots)
    - [shreyas-sha3](https://github.com/shreyas-sha3/niri-dotsd)
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
- wallpapers
    - [dharmx - walls](https://github.com/dharmx/walls)
    - [leroiduflow - Wallsync](https://github.com/leroiduflow/WallSync)
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
- Subreddits
    - [Archlinux](https://reddit.com/r/archlinux/)
    - [Unixporn](https://reddit.com/r/unixporn/)
    - [Linux](https://reddit.com/r/linux/)

## TODOs

- Write command for partionining the disk (swap) to resolve `systemctl hibernate` issue
- Setup [btrfs](https://wiki.archlinux.org/title/Btrfs) and snapshot - Look at Snapper, timeshift...
- Fix issue of cursor being "block" in insert mode in kitty [see this](https://youtube.com/watch?v=hIJh-KlQ7io))
- Update cliphist and keybindings app themes
- Configure hyprland [env vars](https://wiki.hypr.land/Configuring/Environment-variables/)
- Deactive / remove bottom layer of waybar ? It conflicts with the applications by hovering over them
    - Specifically stops from interacting with buttons...
- Add useful search by grep cmds with native linux cmds.. optionally just configure them in nvim
    - [man grep](https://man7.org/linux/man-pages/man1/grep.1.html)
    - [man find](https://man7.org/linux/man-pages/man1/find.1.html)
    - chatgpt produced these:
        - find /path -type f -name "*.txt" -exec grep "string" {} +
        - find /path -type f -name "*.txt" -print0 | xargs -0 grep "string"

