#!/bin/sh
# Stop both manual and service instances before starting the managed bar.
systemctl --user stop waybar.service || exit 1
pkill -x waybar || :
systemctl --user start waybar.service
