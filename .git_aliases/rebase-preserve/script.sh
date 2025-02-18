#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

git -c rebase.instructionFormat='%s%nexec git copy-commit-metadata --committer --author --committer-date --author-date %H' rebase $@
