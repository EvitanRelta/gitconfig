#!/bin/sh
. ~/.git-aliases/_common.sh

in_prog_cmd="$(git get-in-prog-cmd)" &&
    echo "Aborting $in_prog_cmd..." &&
    eval "git $in_prog_cmd --abort" ||
    git has-unmerged &&
    echo "...but has unmerged paths" &&
    echo "Resetting unmerged paths..." &&
    git reset --merge
