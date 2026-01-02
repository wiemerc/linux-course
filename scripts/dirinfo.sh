#!/bin/bash
if [[ $# != 1 ]]; then
    echo "Aufruf: $0 <Verzeichnis>"
    exit 1
fi
cd $1
for entry in *; do
    if [[ -d $entry ]]; then
        num_files=$(find $entry -type f | wc -l)
        used_space=$(du -hs $entry | cut -f1)
        echo "Unterverzeichnis $entry enthält $num_files Dateien und belegt $used_space Plattenplatz"
    fi
done
