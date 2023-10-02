#!/bin/sh
. ~/.git-aliases/_common.sh

in_prog_cmd="$(git get-in-prog-cmd)" &&
    echo "Continuing $in_prog_cmd..." &&
    eval "git $in_prog_cmd --continue"
