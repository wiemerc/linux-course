#!/bin/bash
set -o errexit
set -o pipefail
while IFS= read -r line; do
    if printf '%s' "$line" | grep -q "$2"; then
        printf "String '%s' found in log file %s\n" "$2" "$1"
        ping -c1 localhost
    fi
done < <(tail -f "$1")
