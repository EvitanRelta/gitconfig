#!/bin/bash

# Check if `EXEC_IN_REPO_ROOT` is not set to true
if [ "${EXEC_IN_REPO_ROOT}" != "true" ]; then
    # Change to the `GIT_PREFIX` directory or current directory if `GIT_PREFIX` is not set
    cd "${GIT_PREFIX:-.}"
fi

# Check if the `--docs` flag is provided in any position
for arg in "$@"; do
    if [ "$arg" = "--docs" ]; then
        # Display the documentation for the alias
        cat "$(dirname "$0")/docs.md"
        exit 0
    fi
done
