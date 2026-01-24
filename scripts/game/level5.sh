#!/bin/bash
# cSpell:dictionaries: de-de


set -o errexit
set -o pipefail


#> Das Geheimnis befindet sich in der Datei `geheimnis.txt`, wurde aber mit einer Verschiebechiffre verschlüsselt => Alle Buchstaben müssen um 13 Stellen im Alphabet verschoben werden => a wird zu n usw.


echo linuxisttoll | sed y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM/ > geheimnis.txt
