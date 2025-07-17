#!/usr/bin/env bash

read -n 1 -p "$1 (y/n)" res
echo

if [[ "$res" == [Yy] ]]; then
  exit 0
else 
  echo "Cancelled"
  exit 1
fi

# Usage
# if ./confirm.sh $arg > /dev/null; then
#   **logic**
# else
#   **logic**
# fi

