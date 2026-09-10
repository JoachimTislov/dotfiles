#!/usr/bin/env bash
set -euo pipefail

output_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$output_dir"
file="$output_dir/recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"

if pgrep -x wf-recorder >/dev/null; then
    pkill -INT -x wf-recorder
    notify-send 'Screen recording' 'Recording saved'
    exit 0
fi

geometry=$(slurp)
[[ -n "$geometry" ]] || exit 0
wf-recorder -g "$geometry" -f "$file" &
notify-send 'Screen recording' "Recording started: $(basename "$file")"
