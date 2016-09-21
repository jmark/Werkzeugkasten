#!/bin/bash

# Rename image files with exif header data to there timestamps, respectivaly. 
# Note: Both perl one-liners can be rewritten with unix tools: cut and sed in
#       much more portable and concise way.

for file in $(find . -type f)
do
    tstmp=$(exiv2 "$file" \
     | grep -ia "image timestamp" \
     | perl -ne '@foo=split / /; print "$foo[-2]_$foo[-1]";' \
     | perl -ne 's/:/-/g; print;');

    mv -v "$file" "$tstmp-$file";
done
