#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'ps -ef'
wait

clear
pei 'ps -u mvhs -f'
pei 'ps -u mvhs -o user,pid,ppid,lstart,stat,vsz,rsz,%cpu,%mem,args'
wait

clear
pei 'ps -o user,pid,ppid,lstart,stat,vsz,rsz,%cpu,%mem,args -C systemd'
pei 'pgrep -af systemd'
wait

pei 'sleep infinity &'
pei 'pgrep -af sleep'
pei 'pkill -f sleep'
pei 'pgrep -af sleep'
