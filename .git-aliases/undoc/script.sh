#!/bin/sh
. ~/.git-aliases/_common.sh

if [ $# -eq 0 ]; then
    git reset --soft HEAD~
elif [ $# -eq 1 ] && [ $1 == "-f" ]; then
    git reset --hard HEAD~
else
    echo Invalid parameters
fi
