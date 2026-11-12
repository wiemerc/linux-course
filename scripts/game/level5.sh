#!/bin/bash
# cSpell:dictionaries: de-de


set -o errexit
set -o pipefail


#de> Das Geheimnis befindet sich in der Datei `geheimnis.txt`, wurde aber mit einer Verschiebechiffre verschlüsselt => Alle Buchstaben müssen um 13 Stellen im Alphabet verschoben werden => a wird zu n usw.
#en> You can find the secret in the file `geheimnis.txt`, but it has been encrypted using a shift cipher => All letters must be shifted 13 places in the alphabet => “a” becomes “n” and so on.


echo linuxisttoll | sed y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM/ > geheimnis.txt
