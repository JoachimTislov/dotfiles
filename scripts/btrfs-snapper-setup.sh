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

# Keep automatic snapshots useful without allowing them to consume the root
# filesystem indefinitely. These settings are safe to apply repeatedly.
sudo snapper -c root set-config \
    TIMELINE_CREATE=yes \
    TIMELINE_CLEANUP=yes \
    NUMBER_CLEANUP=yes \
    NUMBER_MIN_AGE=1800 \
    NUMBER_LIMIT=10 \
    NUMBER_LIMIT_IMPORTANT=10 \
    TIMELINE_MIN_AGE=1800 \
    TIMELINE_LIMIT_HOURLY=5 \
    TIMELINE_LIMIT_DAILY=7 \
    TIMELINE_LIMIT_WEEKLY=4 \
    TIMELINE_LIMIT_MONTHLY=6 \
    TIMELINE_LIMIT_YEARLY=0

sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
echo "Snapper root configuration and timers are enabled."
