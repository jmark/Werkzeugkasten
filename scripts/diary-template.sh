#!/usr/bin/bash

# Print day-wise calendor for journalling.

for i in $(seq 1 14)
do 
    date "+> %Y %m %d %V %a" --date "$i days"
    for j in $(seq -w 6 20)
    do
        echo -e "  * $j:00: "
    done
    echo
done
