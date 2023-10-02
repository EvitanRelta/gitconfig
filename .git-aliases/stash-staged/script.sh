#!/bin/sh
. ~/.git-aliases/_common.sh

git stash-unstaged --quiet &&
    git stash -u "$@" &&
    git stash pop --quiet stash@{1}
