#!/bin/sh
. ~/.git-aliases/_common.sh

GIT_COMMITTER_DATE="$2" git commit --date="$1" --amend --no-edit
