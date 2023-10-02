#!/bin/sh
. ~/.git-aliases/_common.sh

git show-ref --quiet "refs/heads/$1"
