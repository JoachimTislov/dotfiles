#!/usr/bin/env bash
set -Eeuo pipefail

if ! command -v os-prober >/dev/null 2>&1; then
  echo "os-prober is not installed; install it before configuring Windows boot entries." >&2
  exit 1
fi

if ! lsblk -f | grep -Eiq 'Windows|ntfs'; then
  echo "No Windows or NTFS filesystem detected; leaving the boot menu unchanged."
  exit 0
fi

# A drop-in survives package updates and works whether /etc/default/grub had the
# setting commented out, missing, or supplied by another configuration file.
sudo install -d -m 0755 /etc/default/grub.d
printf '%s\n' 'GRUB_DISABLE_OS_PROBER=false' | sudo tee /etc/default/grub.d/10-os-prober.cfg >/dev/null

detected=$(sudo os-prober || true)
if [[ -z "$detected" ]]; then
  echo "os-prober did not find a bootable Windows installation." >&2
  echo "Check that Windows was shut down fully (disable Fast Startup) and that its EFI partition is accessible." >&2
  exit 1
fi

printf '%s\n' "$detected"
sudo grub-mkconfig -o /boot/grub/grub.cfg

if ! sudo grep -Eiq 'Windows|os-prober' /boot/grub/grub.cfg; then
  echo "GRUB was regenerated but contains no Windows entry." >&2
  exit 1
fi
echo "Windows boot entry configured."
