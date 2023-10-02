#!/bin/sh
. ~/.git-aliases/_common.sh

if [ -n "$(git status --porcelain)" ]; then
    echo "error: There are local changes."
    echo "Aborting..."
elif [ $# -eq 0 ]; then
    git fetch -p
    echo "From $(git remote get-url origin)"
    for remote_branch in `git branch -r | grep -v " -> " | grep "origin/"`; do
        branch=${remote_branch#origin/} &&
            git fetch --update-head-ok origin "$branch:$branch" 2>&1 | grep -v "From" &&
            git branch --quiet -u "$remote_branch" "$branch"
    done
elif [ $# -gt 1 ] && [ $1 == "-s" ]; then
    git fetch -p
    echo "From $(git remote get-url origin)"
    for remote_branch in `git branch -r | grep -v " -> " | grep "origin/"`; do
        branch=${remote_branch#origin/}
        for ignore_branch in "$@"; do
            if [ "$branch" == "$ignore_branch" ]; then
                echo "Skipped \"$branch\""
                continue 2
            fi
        done
        git fetch --update-head-ok origin "$branch:$branch" 2>&1 | grep -v "From" &&
            git branch --quiet -u "$remote_branch" "$branch"
    done
else
    echo Invalid parameters
fi
