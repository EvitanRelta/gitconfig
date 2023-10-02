#!/bin/sh
. ~/.git-aliases/_common.sh

if [ $# -eq 1 ]; then
    commit_subject=$(git log --format=%s -n 1 "$1") &&
        branch_name=$(grep -Po "(?<=')[^']+(?=')" <<< "$commit_subject" | head -1) &&
        git checkout -b "$branch_name" "$1^2" &&
        git checkout -
else
    echo Invalid parameters
fi
