#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'ls -ld /etc/systemd/system/*.wants'
pei 'ls -l /etc/systemd/system/sysinit.target.wants'
wait

clear
pei 'cat /usr/lib/systemd/system/systemd-resolved.service'
wait

clear
pei 'systemctl status systemd-resolved.service'
pei 'sudo systemctl reload systemd-resolved.service'
pei 'sudo journalctl --since "5 minutes ago" -u systemd-resolved.service'
wait

clear
pei 'logger -p user.notice "Hello Linux :-)"'
pei 'sudo journalctl --facility user --since "5 minutes ago" -o verbose'
