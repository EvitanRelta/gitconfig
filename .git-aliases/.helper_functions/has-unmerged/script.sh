#!/bin/sh
. ~/.git-aliases/_common.sh

git ls-files --unmerged | grep -q .
