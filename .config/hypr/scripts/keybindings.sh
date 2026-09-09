#!/bin/bash

keybinds=$(hyprctl binds -j | jq -r '
    .[] |
    .modmask as $mask |
    ([
        if ($mask / 64 | floor) % 2 == 1 then "SUPER" else empty end,
        if ($mask / 4 | floor) % 2 == 1 then "CTRL" else empty end,
        if ($mask / 8 | floor) % 2 == 1 then "ALT" else empty end,
        if $mask % 2 == 1 then "SHIFT" else empty end,
        if .key != "" then .key else "code:\(.keycode)" end
    ] | join(" + ")) + "\r" +
    (if (.description // "") != "" then .description else .dispatcher + " " + .arg end)
')

rofi -dmenu -i -l 6 -eh 2 -p "Keybinds" <<< "$keybinds"
