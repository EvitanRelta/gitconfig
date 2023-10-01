#!/bin/sh
. ~/.git-aliases/_common.sh

git stash pop "$@"
