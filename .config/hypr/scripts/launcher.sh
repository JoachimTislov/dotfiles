#!/bin/sh
exec rofi -no-config -theme "$HOME/.config/hypr/conf/launcher.rasi" \
    -show drun -replace -i \
    -run-command "$HOME/.config/hypr/scripts/launch-or-focus.py {cmd}"
