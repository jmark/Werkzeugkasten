#!/usr/bin/bash

DEVICE='smfp:net;192.168.178.21'
SCAN_CMD="scanimage -d ${DEVICE} -l 0 -t 0 -x 215 -y 297 --resolution 150"
CONV_CMD="convert - -quality 30" 
IMG_EXT="jpg"
PREFIX=''
#SOUND=mplayer -ao pulse::0 "/usr/share/sounds/freedesktop/stereo/window-attention.oga" &> /dev/null

while true 
do
    STAMP="${PREFIX}$(date +%Y-%m-%d-%H-%M-%S-%N)"
    echo "[Scanning...] ${STAMP}.${IMG_EXT}"
    
    ${SCAN_CMD} | ${CONV_CMD} ${STAMP}.${IMG_EXT} && ${SOUND}

    read -t 0.001 -N 4096 # clear keyboard buffer
    read -n 1 -s KEY
    if test ${KEY} = q
    then
        break
    elif test ${KEY} = p
    then
        read -p 'Prefix: ' PREFIX
    fi
done
