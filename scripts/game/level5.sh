#!/bin/bash
# cSpell:dictionaries: de-de


set -o errexit
set -o pipefail


#de> Das Geheimnis ist die Summe der Zahlen in den Dateien im Verzeichnis `numbers`.
#en> The secret is the sum of the numbers in the files in the directory `numbers`.


rm -rf numbers
mkdir numbers
for i in $(seq 1 100); do
    od -An -N2 -tu2 /dev/urandom | tr -d ' ' > numbers/num$i.txt
done
