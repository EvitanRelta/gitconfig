#!/bin/sh
. ~/.git-aliases/_common.sh

git fetch &&
    git reset --hard "origin/$(git branch --show-current)"
