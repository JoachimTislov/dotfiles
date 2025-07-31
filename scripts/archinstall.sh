#!/usr/bin/env bash

# !! IMPORTANTE !! This file is meant for local installations.
# User config and creds json files are required!
# Copy the files to a flashdrive and run the following commands:
# mkdir /mnt/ventoy
# mount /dev/mapper/*disk name* /mnt/ventoy
# sh /mnt/ventoy/*path to this file*

if ping -c 1 archlinux.org &>/dev/null; then
  echo "✅ Internet is available."
else
  echo "❌ No internet connection."
  sleep 0.5
  echo "Getting close networks"
  iwctl station wlan0 get-networks
  read -p "Input name of network: " name
  read -p "Password: " password
  iwctl station wlan0 connect "$name" -P "$password"
fi

read -p "Input path to folder with config and creds files" dir

archinstall --config "${dir}/user_configuration.json" --creds "${dir}/user_credentials.json"
