#!/bin/sh

# Skript zum Herunterladen von Videos von bestimmten Mediatheken
#
# So muss ein Link aussehen: http://wstreaming.zdf.de/3sat/veryhigh/100204_internet_scobel.asx

if [$# < 2]
then
   echo "Didn't passed two arguments!"
   exit
fi

curl $1 | sed -n '/mms/p' | sed 's/ *<Ref href="//g'| sed 's/"\/> *//g' | xargs -I@ mplayer @ -dumpstream -dumpfile $2 &
