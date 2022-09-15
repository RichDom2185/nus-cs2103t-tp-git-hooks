#!/bin/bash

ret=0

idx=1
files="${@:idx}"

grep -n ' \+$' $files |
awk '
    BEGIN {
        FS = ":"
        OFS = ":"
        ret = 0
    }
    {
        # Only warn for markdown files (*.md) to accomodate text editors
        # which do not properly handle trailing whitespace.
        # (e.g. GitHub web editor)
        if ($1 ~ /\.md$/) {
            severity = "[WARN] "
        } else {
            severity = "[ERROR] "
            ret = 1
        }
        print severity $1, $2, " Trailing whitespace."
    }
    END {
        exit ret
    }
'