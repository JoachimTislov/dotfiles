#!/bin/bash

keybinds=$(awk -F'[=#]' '
    $1 ~ /^bind/ {
        # Replace the string "$mainMod" with "SUPER" (for the super key)
        gsub(/\$mainMod/, "SUPER", $0)

        # Remove "bind" and extra spaces, if any, at the beginning of the line
        gsub(/^bind[[:space:]]*=+[[:space:]]*/, "", $0)

        # Split the keybinding part (e.g., "Mod1,Return") using a comma
        split($1, kbarr, ",")

        # Format the keybinding and associated command and prepare for output:
        # Concatenate the two keybinding keys (e.g., "Mod1" + "Return") and append the command
        print kbarr[1] "  + " kbarr[2] "\r" $2
    }
  ' ~/.config/hypr/conf/keybindings.conf)

rofi -dmenu -i -markup -l 6 -eh 2 -p "Keybinds" <<< "$keybinds"

