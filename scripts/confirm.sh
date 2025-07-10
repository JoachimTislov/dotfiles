#!/usr/bin/env bash

echo "$1 (y/...)"
read res

if [[ "$res" == "y" || "$res" == "Y" ]]; then
  exit 0 
else 
  exit 1
fi

# Usage
# if ./confirm.sh $arg > /dev/null; then
#   **logic**
# else
#   **logic**
# fi

