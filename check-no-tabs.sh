#!/bin/bash

ret=0

idx=1
files="${@:idx}"

grep -n $'\t' $files |
awk '
    BEGIN {
        FS = ":"
        OFS = ":"
        ret = 0
    }
    {
        ret = 1
        print "[ERROR] " $1, $2, " Contains tabs."
    }
    END {
        exit ret
    }
'
