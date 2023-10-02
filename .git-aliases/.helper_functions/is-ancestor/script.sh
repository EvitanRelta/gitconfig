#!/bin/sh
. ~/.git-aliases/_common.sh

git merge-base --is-ancestor "$@"
