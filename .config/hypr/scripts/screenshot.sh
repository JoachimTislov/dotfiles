#!/usr/bin/env bash

if [ ! -d $SCREENSHOT_DIR ]; then
  mkdir -p $SCREENSHOT_DIR
fi

slurp | grim -g - - | tee $SCREENSHOT_DIR/$(date +%s).png | wl-copy
