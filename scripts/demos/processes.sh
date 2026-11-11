#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'ps -ef'
wait

clear
pei 'ps -u $(id -un) -f'
pei 'ps -u $(id -un) -o user,pid,ppid,lstart,stat,vsz,rsz,%cpu,%mem,args'
wait

clear
pei 'ps -o user,pid,ppid,lstart,stat,vsz,rsz,%cpu,%mem,args -C systemd'
pei 'pgrep -af systemd'
wait

pei 'sleep infinity &'
pei 'pgrep -a sleep'
pei 'pkill sleep'
pei 'pgrep -a sleep'
