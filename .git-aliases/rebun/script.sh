#!/bin/sh
. ~/.git-aliases/_common.sh

GIT_SEQUENCE_EDITOR="perl -0777 -i -pe 's/pick/$1/'" git rebase -i --rebase-merges "$2"~
