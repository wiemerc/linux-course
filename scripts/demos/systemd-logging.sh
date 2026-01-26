#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'ls -ld /etc/systemd/system/*.wants'
pei 'ls -l /etc/systemd/system/multi-user.target.wants'
wait

clear
pei 'cat /usr/lib/systemd/system/sshd.service'
wait

clear
pei 'systemctl status sshd.service'
pei 'sudo systemctl reload sshd.service'
pei 'sudo journalctl --since "5 minutes ago" -u sshd.service'
wait

clear
pei 'logger -p user.notice "Hallo MVHS :-)"'
pei 'sudo journalctl --facility user --since "5 minutes ago" -o verbose'
