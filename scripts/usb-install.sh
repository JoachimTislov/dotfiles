#!/usr/bin/env bash

# !! IMPORTANTE !! This file is meant for local installations.
# User config and creds json files are required!
# Copy this file to a flashdrive and run the following commands:
# $ mount /dev/mapper/ventoy/ /mnt/ventoy
# $ sh /mnt/ventoy/scripts/usb-install.sh

if ping -c 1 archlinux.org &> /dev/null; then
  echo "✅ Internet is available."
else
  echo "❌ No internet connection."
  iwctl station wlan0 get-networks
  echo "Input name of network: "
  read $name
  echo "Password: "
  read $password
  iwctl station wlan0 connect $name -P $password
fi

echo "Input path to folder with config and creds files"
read $dir

archinstall --config "${dir}/user_configuration.json" --creds "${dir}/user_credentials.json"

sh "${wget https://github.com/JoachimTislov/tree/blob/main/scripts/web-install.sh}"

