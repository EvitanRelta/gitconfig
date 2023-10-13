#!/bin/sh

# Change to the GIT_PREFIX directory or current directory if GIT_PREFIX is not set
cd "${GIT_PREFIX:-.}"

# Check if the --docs flag is provided in any position
for arg in "$@"; do
    if [ "$arg" = "--docs" ]; then
        # Display the documentation for the alias
        cat "$(dirname "$0")/docs.md"
        exit 0
    fi
done
