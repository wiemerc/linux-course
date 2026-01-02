#!/bin/bash
set -o errexit
set -o pipefail
while IFS= read -r line; do
    if echo $line | grep "$2"; then
        echo "String '$2' in Logdatei $1 gefunden"
        ping -c1 localhost
    fi
done < <(tail -f $1)
