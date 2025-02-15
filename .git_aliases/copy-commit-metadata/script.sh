#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

# Default: no flags are enabled
copy_committer=false
copy_author=false
copy_committer_date=false
copy_author_date=false
copy_message=false
copy_all=false

# Parse arguments
commit_hash=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --all)
            copy_all=true
            shift
            ;;
        --committer)
            copy_committer=true
            shift
            ;;
        --author)
            copy_author=true
            shift
            ;;
        --committer-date)
            copy_committer_date=true
            shift
            ;;
        --author-date)
            copy_author_date=true
            shift
            ;;
        --message)
            copy_message=true
            shift
            ;;
        --*)
            echo "Error: Unknown option $1"
            echo "Valid options: --all, --committer, --author, --committer-date, --author-date, --message"
            exit 1
            ;;
        *)
            if [ -z "$commit_hash" ]; then
                commit_hash="$1"
                shift
            else
                echo "Error: Too many arguments. Only one commit hash is allowed."
                exit 1
            fi
            ;;
    esac
done

# Check if commit hash is provided
if [ -z "$commit_hash" ]; then
    echo "Error: Commit hash is required"
    exit 1
fi

# Check if at least one option was selected
if [ "$copy_committer" = false ] && [ "$copy_author" = false ] && 
   [ "$copy_committer_date" = false ] && [ "$copy_author_date" = false ] && 
   [ "$copy_message" = false ] && [ "$copy_all" = false ]; then
    echo "Error: At least one option must be specified"
    echo "Valid options: --all, --committer, --author, --committer-date, --author-date, --message"
    exit 1
fi


# If --all is specified, enable all flags
if [ "$copy_all" = true ]; then
    copy_committer=true
    copy_author=true
    copy_committer_date=true
    copy_author_date=true
    copy_message=true
fi

# Initialize git command parameters
git_env=""
git_params="--amend --no-edit"

# Get and apply committer info if requested
if [ "$copy_committer" = true ]; then
    committer_name=$(git show -s --format='%cn' "$commit_hash")
    committer_email=$(git show -s --format='%ce' "$commit_hash")
    git_env+="GIT_COMMITTER_NAME=\"$committer_name\" GIT_COMMITTER_EMAIL=\"$committer_email\" "
fi
    
if [ "$copy_committer_date" = true ]; then
    committer_date=$(git show -s --format='%cd' "$commit_hash")
    git_env+="GIT_COMMITTER_DATE=\"$committer_date\" "
fi

# Get and apply author info if requested
if [ "$copy_author" = true ]; then
    author_name=$(git show -s --format='%an' "$commit_hash")
    author_email=$(git show -s --format='%ae' "$commit_hash")
    git_params+=" --author=\"$author_name <$author_email>\""
fi

# Get and apply author date if requested
if [ "$copy_author_date" = true ]; then
    author_date=$(git show -s --format='%ad' "$commit_hash")
    git_params+=" --date=\"$author_date\""
fi

# Get and apply commit message if requested
if [ "$copy_message" = true ]; then
    commit_message=$(git show -s --format='%B' "$commit_hash")
    git_params+=" -m \"$commit_message\""
fi


# Execute the git command
eval $git_env git commit $git_params

echo "Successfully copied selected information from commit $commit_hash"
