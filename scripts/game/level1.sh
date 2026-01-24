#!/bin/bash
# cSpell:dictionaries: de-de


set -o errexit
# `tr` (obviously) fails with pipe fail (return code 141) because `head`` terminates once it's read 16 bytes,
# so we can't use the option below.
# set -o pipefail


#> Das Geheimnis befindet sich in den beiden Dateien in diesem Verzeichnis, deren Namen mit einem Sonderzeichen beginnen.


(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16; echo) > ./.geheimnis1.txt
(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16; echo) > ./-geheimnis2.txt
