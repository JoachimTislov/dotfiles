#!/usr/bin/env bash

# Get boot device
BOOTDEV=$(findmnt -n -o SOURCE / | sed 's/[0-9]*$//')
BOOTDEV_NAME=$(basename $BOOTDEV)

# Get total ram
RAM="$(free -g | awk '/^Mem:/ {print $2}')"

# TODO: ADD LUKS for encryption
# Partition disk EFI : SWAP : LINUX
# sfdisk *device* << EOF
# label: gpt
# ,512M,U
# $RAM,S
# ,,
# mkfs.btrfs /dev/*device*3

mapfile -t DISKS < <(lsblk -dno NAME -e 7,11 | grep -v "^$BOOTDEV_NAME$")

# Check if we found any disks
if [ ${#DISKS[@]} -eq 0 ]; then
    echo "No disks found."
    exit 1
fi

echo "Disks" 
echo "----------------------------------------------"

for i in "${!DISKS[@]}"; do
  disk="${DISKS[$i]}"

  if [ -z "$(readlink /sys/block/$disk/device)" ]; then
    continue
  fi
 
  echo "$i) Disk: /dev/$disk"

  # Use fdisk to list partitions on this disk
  sudo fdisk -l /dev/$disk | awk '
    BEGIN {p=0}
    /^Device/ {p=1; next}
    p && NF {
      printf "  %-20s | Size: %-8s | Type: %s %s\n", $1, $5, $6, $7
    }'
  echo "----------------------------------------------"
done

# Keep asking user until valid input is provided
while true; do
    read -p "Enter the number corresponding to the target disk: " selection
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 0 ] && [ "$selection" -lt "${#DISKS[@]}" ]; then
        TARGET="/dev/${DISKS[$selection]}"
        echo "Selected target disk: $TARGET"
        break
    else
        echo "Invalid selection. Please enter a valid number from the list above."
    fi
done

