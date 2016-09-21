#!/bin/bash
wget 'http://192.168.2.1/cgi-bin/disconnect.exe' -O /dev/null > /dev/null 2>&1
sleep 3
wget 'http://192.168.2.1/cgi-bin/connect.exe' -O /dev/null > /dev/null 2>&1
sleep 30
