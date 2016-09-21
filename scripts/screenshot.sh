#!/usr/bin/env bash

STAMP=$(date +%Y-%m-%d-%H-%M-%S-%s)

mkdir -pf ~/drop/screenshots

import -window root png:$HOME/drop/screenshots/$STAMP.png
