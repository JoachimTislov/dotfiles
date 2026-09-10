#!/usr/bin/env bash
set -Eeuo pipefail

if [[ ${1:-} != --apply ]]; then
    echo "Dry run: choose a disk below. Re-run with --apply only after verifying it."
fi

# Get boot device
ROOT_SOURCE=$(findmnt -n -o SOURCE /)
BOOTDEV_NAME=$(lsblk -no PKNAME "$ROOT_SOURCE" 2>/dev/null || true)
BOOTDEV_NAME=${BOOTDEV_NAME:-$(basename "$ROOT_SOURCE" | sed -E 's/p?[0-9]+$//')}

# Get total ram
RAM="$(free -b | awk '/^Mem:/ {print $2}')"
RAM_MIB=$((RAM / 1024 / 1024 + 1023))

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

if [[ ${1:-} != --apply ]]; then
    exit 0
fi

# Select the target only after displaying all disks. A normal apply refuses a
# disk that already has partitions, so rerunning setup cannot erase it.
while true; do
    read -r -p "Enter the number corresponding to the target disk: " selection
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 0 ] && [ "$selection" -lt "${#DISKS[@]}" ]; then
        TARGET="/dev/${DISKS[$selection]}"
        echo "Selected target disk: $TARGET"
        break
    else
        echo "Invalid selection. Please enter a valid number from the list above."
    fi
done

if [[ ${2:-} != --force ]] && lsblk -nro NAME "/dev/${DISKS[$selection]}" | tail -n +2 | grep -q .; then
    echo "Refusing to overwrite $TARGET because it already has partitions. Use --force only when you intend to erase it." >&2
    exit 1
fi

read -r -p "ERASE ALL DATA on $TARGET and create EFI/swap/btrfs partitions? Type ERASE: " confirmation
[[ "$confirmation" == ERASE ]] || { echo "Cancelled."; exit 1; }

sudo wipefs --all "$TARGET"
printf 'label: gpt\n,512M,U\n,%sM,S\n,,L\n' "$RAM_MIB" | sudo sfdisk --wipe always "$TARGET"
part_prefix="$TARGET"
[[ "$TARGET" =~ [0-9]$ ]] && part_prefix="${TARGET}p"
sudo mkfs.fat -F32 "${part_prefix}1"
sudo mkswap "${part_prefix}2"
sudo mkfs.btrfs -f "${part_prefix}3"
echo "Created EFI, swap and btrfs partitions. Add resume=UUID=$(blkid -s UUID -o value "${part_prefix}2") to the kernel command line and enable the resume mkinitcpio hook for hibernation."
