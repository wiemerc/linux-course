#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'cd  # change to the home directory'
pei 'ls -l'
pei 'ls -la  # with hidden files / directories'
wait

clear
pei 'cd /tmp'
pei umask

pei 'mkdir bla/'
pei 'touch bla/blub.txt'
pei 'ls -ld bla/  # permissions = 0777 - umask'
pei 'ls -l bla/  # permissions = 0666 - umask'
wait

pei 'cd bla'
pei 'chmod u=r,g=r,o= blub.txt'
pei 'ls -lc blub.txt'
pei 'echo "Hello Linux:-)" > blub.txt'
wait

pei 'ls -ld  # timestamps before'
pei 'ls -l'
wait
pei 'mv blub.txt blablub.txt'
pei 'ls -ld  # Timestamp of the folder has changed.'
pei 'ls -l  # Timestamp of the file has *not* changed.'
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
pei 'ln -sr bla/zero blub/link  # ln determines the correct target path itself.'
pei 'ls -l blub/link'
