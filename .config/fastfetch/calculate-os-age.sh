#!/usr/bin/env bash

birth_install=$(stat -c %W /)
current=$(date +%s)
time_progression=$((current - birth_install))

days=$((time_progression / 86400))

years=$((days / 365))
remaining_days=$((days % 365))
months=$((remaining_days / 30))
days_left=$((remaining_days % 30))

output=""

if [ $years -gt 0 ]; then
    output="${years} years"
fi

if [ $months -gt 0 ]; then
    if [ -n "$output" ]; then
        output="$output, "
    fi
    output="${output}${months} months"
fi

if [ -n "$output" ]; then
    output="${output}, "
fi

output="${output}${days_left} days (age)"

echo "$output"
