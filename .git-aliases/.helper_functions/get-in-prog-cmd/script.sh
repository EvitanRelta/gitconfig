#!/bin/sh
. ~/.git-aliases/_common.sh

if git is-rebasing; then
    echo rebase
elif git is-merging; then
    echo merge
elif git is-cherry-picking; then
    echo cherry-pick
elif git is-reverting; then
    echo revert
else
    >&2 echo "Not currently rebasing, merging, cherry-picking nor revert"
    exit 1
fi
