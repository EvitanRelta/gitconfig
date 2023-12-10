#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

if [ $# -ne 1 ]; then
    echo Invalid parameters
    exit 1
fi
git reset --hard "$1"
git branch -D "$1"
