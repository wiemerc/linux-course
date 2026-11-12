#!/bin/bash
# cSpell:dictionaries: de-de


set -o errexit
# `tr` (obviously) fails with pipe fail (return code 141) because `head`` terminates once it's read 16 bytes,
# so we can't use the option below.
# set -o pipefail


#de> Das Geheimnis befindet sich in der einzigen Datei in diesem Verzeichnis, die Text enthält.
#en> You can find the secret in the only file in this directory that contains text.


head -c 17 < /dev/zero > ./datei1
(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16; echo) > ./datei2
head -c 17 < /dev/zero > ./datei3
