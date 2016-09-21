#!/usr/bin/bash

while true
do
    echo -e "HTTP/1.1 200 OK\n\n $(date)" \
    | nc -l -p 14778 \
    | grep -iP "^http://" \
    | xargs uget-gtk
done
