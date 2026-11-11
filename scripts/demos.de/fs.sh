#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'cd  # Wechseln ins Heimatverzeichnis'
pei 'ls -l'
pei 'ls -la  # mit versteckten Dateien / Verzeichnissen'
wait

clear
pei 'cd /tmp'
pei umask

pei 'mkdir bla/'
pei 'touch bla/blub.txt'
pei 'ls -ld bla/  # Berechtigungen = 777 - umask'
pei 'ls -l bla/  # Berechtigungen = 666 - umask'
wait

pei 'cd bla'
pei 'chmod u=r,g=r,o= blub.txt'
pei 'ls -lc blub.txt'
pei 'echo "Hallo MVHS :-)" > blub.txt'
wait

pei 'ls -ld  # Zeitstempel vorher'
pei 'ls -l'
wait
pei 'mv blub.txt blablub.txt'
pei 'ls -ld  # Zeitstempel hat sich geändert.'
pei 'ls -l  # Zeitstempel hat sich *nicht* geändert.'
wait

pei 'cd ..'
pei 'rmdir bla/'
pei 'rm -r bla/'
pei 'rm -rf bla/'
wait

rm -rf bla blub
pei 'mkdir bla'
pei 'head -c 10 /dev/zero > bla/zero'
pei 'head -c 20 /dev/random > bla/random'
pei 'ls -l bla/'
pei 'hexdump -C bla/zero'
pei 'hexdump -C bla/random'
wait

pei 'cp -r bla blub'
pei 'ls -la blub'
pei 'cp -r bla blub'
pei 'ls -la blub'
pei 'rm -r blub'
pei 'mkdir blub'
pei 'cp -r bla/. blub'
pei 'ls -la blub'
wait

pei 'ln -s bla/zero blub/link'
pei 'ls -l blub/link'
pei 'cat blub/link'
pei 'rm blub/link'
pei 'ln -sr bla/zero blub/link  # ln ermittelt selber den richtigen Pfad für das Ziel.'
pei 'ls -l blub/link'
