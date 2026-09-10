#!/usr/bin/env bash
set -Eeuo pipefail

root_fs=$(findmnt -n -o FSTYPE /)
if [[ "$root_fs" != btrfs ]]; then
    echo "Root filesystem is $root_fs; Snapper root snapshots require btrfs." >&2
    exit 1
fi

if ! snapper -c root list-configs | awk 'NR > 2 {print $1}' | grep -qx root; then
    sudo snapper -c root create-config /
fi

sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
echo "Snapper root configuration and timers are enabled."
