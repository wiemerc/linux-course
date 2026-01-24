#!/bin/bash


set -o errexit
set -o pipefail


GAME_NAME=Schnitzeljagd
NUM_LEVELS=5


script_dir=$(realpath $(dirname $0))
rm -rf ~/$GAME_NAME
mkdir ~/$GAME_NAME
cd ~/$GAME_NAME
for i in $(seq 1 $NUM_LEVELS); do
    echo "Creating level $i..."
    mkdir level$i
    cd level$i
    (cowsay "Willkommen im Level $i :-) Viel Erfolg!"; echo) > README.txt
    grep '^#>' $script_dir/level$i.sh | sed -e 's/^#> //' >> README.txt
    $script_dir/level$i.sh
    cd -
done
