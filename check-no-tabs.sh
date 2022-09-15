#!/bin/bash

ret=0

idx=1
files="${@:idx}"

for filename in $files; do
    if [ "$(grep -n $'\t' $filename)" ]; then
        line=$(grep -n $'\t' $filename | cut -f1 -d:)
        echo "[ERROR] $filename:$line: Contains tabs"
        ret=1
    fi
done

exit $ret
