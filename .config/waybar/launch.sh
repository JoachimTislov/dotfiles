#!/bin/bash

killall waybar
pkill waybar

waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &

