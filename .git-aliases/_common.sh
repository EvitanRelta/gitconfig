#!/bin/sh

# Change to the GIT_PREFIX directory or current directory if GIT_PREFIX is not set
cd "${GIT_PREFIX:-.}"

# Get the name of the alias from the calling script's name
alias_name=$(basename "$0" | sed 's/\.sh$//')

# Check if the --docs flag is provided in any position
for arg in "$@"; do
    if [ "$arg" = "--docs" ]; then
        # Display the documentation for the alias
        cat ~/.git-aliases/docs/${alias_name}.md
        exit 0
    fi
done
