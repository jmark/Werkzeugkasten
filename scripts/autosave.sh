#!/bin/bash

# Periodically make a snapshot of the current project and save it to a folder
# tagged by a timestamp.
# In case there are more than 5 snapshots clip the oldest ones.

set -x

SAVE_DIR=~/save/
PROJ_DIR=~/thesis/latex
DURATION=120
SNAPSHOTS=5

while true
do
    cp -r "${PROJ_DIR}" "${SAVE_DIR}/$(date +%Y-%m-%d-%H-%M-%S)"

    while test $(find ${SAVE_DIR} -type d | wc -l) -gt ${SNAPSHOTS}
    do
        rm -r $(find ${SAVE_DIR} -type d | sort -n  | head -n1)
    done

    sleep ${DURATION}
done
