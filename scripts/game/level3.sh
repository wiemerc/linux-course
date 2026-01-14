#!/bin/bash


set -o errexit
# `tr` (obviously) fails with pipe fail (return code 141) because `head`` terminates once it's read 16 bytes,
# so we can't use the option below.
# set -o pipefail


#> Das Geheimnis befindet sich in einer Datei, die nur vom Besitzer gelesen und geschrieben werden kann und genau 17 Bytes gross ist.


for i in $(seq 1 10); do
    outer_dir=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
    mkdir $outer_dir
    pushd $outer_dir
    for j in $(seq 1 10); do
        inner_dir=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
        mkdir $inner_dir
        pushd $inner_dir
        fname=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
        (LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16; echo) > ./$fname
        if [[ ($i == 6) && ($j == 7) ]]; then
            chmod 0600 $fname
        fi
        popd
    done
    popd
done
