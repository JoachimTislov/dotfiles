# Archinstall profile

`user_configuration.json` is a starting profile for a UEFI installation with
an encrypted LUKS root partition, Btrfs subvolumes, and the packages required
by the repository's Snapper setup.

Before using it:

1. Change `/dev/nvme0n1` to the intended target disk.
2. Review the layout; `"wipe": true` erases that disk.
3. Create a private credentials file containing the Archinstall user and disk
   encryption passwords. Never commit that file.
4. Run `scripts/archinstall.sh` and provide the configuration and credentials
   directory when prompted.

After rebooting into the installed system, run `scripts/setup.sh`. It creates
the Snapper root configuration and enables its timeline and cleanup timers.
