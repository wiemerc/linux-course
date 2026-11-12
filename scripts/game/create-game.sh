#!/bin/bash
# This script has to be run as root on the machine where the game will be played.


set -o errexit
set -o pipefail


NUM_LEVELS=5


if [[ $# != 1 || ($1 != "de" && $1 != "en") ]]; then
    printf "Usage: $0 de|en\n"
    exit 1
fi
lang=$1

script_dir=$(realpath $(dirname $0))
for i in $(seq 1 $NUM_LEVELS); do
    echo "Creating level $i..."
    useradd -c "Linux course level $i" -m level$i
    echo level$i | passwd --stdin level$i
    (COWPATH=/usr/share/cowsay/cows cowsay "Welcome to level $i :-) Good luck!"; echo) | sudo -u level$i tee /home/level$i/README.txt
    grep "^#$lang>" $script_dir/level$i.sh | sed -e "s/^#$lang> //" >> /home/level$i/README.txt
    echo >> /home/level$i/README.txt
    echo "printf '\x1b[1m'; cat ~/README.txt; printf '\x1b[0m'" >> /home/level$i/.bash_profile
    cd /home/level$i
    cp $script_dir/level$i.sh .
    sudo -u level$i ./level$i.sh
    rm ./level$i.sh
    cd -
done
