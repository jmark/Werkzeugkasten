#!/bin/bash

# Rename files in a directory.
#
# This script template is intended for copy and specific adjustment to the
# current situatin.
#
# For general 'file renaming' there is the unix tool 'rename' and the versatile
# 'perl-rename'.

count=0
for file in $(find . -iname '*.jpg' | sort -n)
do
    tmp=$(printf '%03d' $count)
    cp $file prefix_${tmp}.jpg
    count=$(($count + 1))
done
