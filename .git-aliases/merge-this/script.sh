#!/bin/sh
. ~/.git-aliases/_common.sh

branch=$(git get-current-branch) &&
    git checkout master &&
    git merge --no-ff "$branch" &&
    git branch -D "$branch"
