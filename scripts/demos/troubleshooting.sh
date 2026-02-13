#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'sudo csysdig'
pei 'tail -f /etc/hosts &'
pei 'sudo sysdig -c lsof fd.name=/etc/hosts'
pei 'kill %1'
wait

pei 'sudo sysdig -c lsof fd.port=22'
pei 'sudo sysdig -c lsof proc.name=sshd'
pei 'sudo ls -l /proc/$(pgrep -x sshd)/fd'
wait

clear
pei 'last mvhs'
pei 'tail ~/.bash_history  # wird normalerweise erst beim Ausloggen aktualisiert'
