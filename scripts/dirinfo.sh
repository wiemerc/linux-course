#!/bin/bash
if [[ $# != 1 ]]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
cd $1
for entry in *; do
    if [[ -d $entry ]]; then
        num_files=$(find $entry -type f | wc -l)
        used_space=$(du -hs $entry | cut -f1)
        echo "Subdirectory $entry contains $num_files files and uses $used_space disk space"
    fi
done
