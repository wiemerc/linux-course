#!/bin/bash


set -o errexit
# `tr` (obviously) fails with pipe fail (return code 141) because `head`` terminates once it's read 16 bytes,
# so we can't use the option below.
# set -o pipefail


#> Das Geheimnis befindet sich in der Datei `geheimnisse.txt` und beginnt mit drei Ziffern, gefolgt von einem Punkt und 6 Kleinbuchstaben.


for i in $(seq 1 52); do
    (LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c $(shuf -i 8-20 -n 1); echo) >> geheimnisse.txt
done
echo 691.iskjfy >> geheimnisse.txt
for i in $(seq 1 47); do
    (LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c $(shuf -i 8-20 -n 1); echo) >> geheimnisse.txt
done
