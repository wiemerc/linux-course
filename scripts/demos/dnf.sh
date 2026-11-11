#!/bin/bash

. ~/.local/lib/demo-magic.sh
TYPE_SPEED=8

clear
pei 'dnf list lsd'
pei 'sudo dnf install -y lsd'
pei 'dnf list --installed | grep lsd'
