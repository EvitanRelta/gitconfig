#!/bin/sh
EXEC_IN_REPO_ROOT=true . ~/.git-aliases/_common.sh

git ls-files --unmerged | grep -q .
