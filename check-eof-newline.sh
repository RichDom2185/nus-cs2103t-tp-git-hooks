#!/bin/bash

ret=0

idx=1
files="${@:idx}"

for filename in $files; do
    if [ "$(tail -c 1 "./$filename")" != '' ]; then
        line="$(wc -l "./$filename" | cut -d' ' -f1)"
        echo "[ERROR] $filename:$line: no newline at EOF."
        ret=1
    fi
done

exit $ret
