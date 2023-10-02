#!/bin/sh
. ~/.git-aliases/_common.sh

git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" git commit --amend --no-edit' rebase $@
