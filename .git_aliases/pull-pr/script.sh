#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

# Check if the script received the necessary input
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <username:branch> [new_remote_name]"
    exit 1
fi

# Split input into username and branch
IFS=':' read -ra ADDR <<< "$1"
USERNAME=${ADDR[0]}
BRANCH=${ADDR[1]}
NEW_REMOTE_NAME=${2:-$USERNAME}

# Search the remote name with the URL containing the username
REMOTE_NAME=$(git remote -v | grep "$USERNAME" | awk '{print $1}' | uniq)

# Check if the remote name is found
if [ -z "$REMOTE_NAME" ]; then
    echo "No remote found with URL containing '$USERNAME'"
    
    # Extract the URL of the 'origin' remote
    ORIGIN_URL=$(git remote get-url origin)
    
    # Extract repository from the `origin` URL
    REPO=$(echo "$ORIGIN_URL" | awk -F/ '{print $NF}')

    # Construct new URL
    NEW_URL="https://github.com/$USERNAME/$REPO"
    
    # Add a new remote with the new URL
    git remote add "$NEW_REMOTE_NAME" "$NEW_URL"
    REMOTE_NAME="$NEW_REMOTE_NAME"

# If new remote name (ie. $2) is given
elif [ -n "$2" ]; then
    # And found remote name doesn't equal to the new provided name, rename it
    if [ "$REMOTE_NAME" != "$NEW_REMOTE_NAME" ]; then
        git remote rename "$REMOTE_NAME" "$NEW_REMOTE_NAME"
        REMOTE_NAME="$NEW_REMOTE_NAME"
    fi
fi

# Fetch from the identified/modified remote
git fetch "$REMOTE_NAME"

# Check if the branch exists in the remote
if ! git show-ref --verify --quiet "refs/remotes/$REMOTE_NAME/$BRANCH"; then
    echo "Branch '$BRANCH' not found in remote '$REMOTE_NAME'"
    exit 1
fi

# Check if local branch already exists
LOCAL_BRANCH="$REMOTE_NAME-$BRANCH"
if git show-ref --verify --quiet "refs/heads/$LOCAL_BRANCH"; then
    # Branch exists, checkout and hard reset to remote branch
    echo "Branch '$LOCAL_BRANCH' already exists, performing hard reset to remote branch"
    git checkout "$LOCAL_BRANCH"
    git reset --hard "$REMOTE_NAME/$BRANCH"
else
    # Create and checkout to a new branch, set to track the remote branch
    git checkout -b "$LOCAL_BRANCH" "$REMOTE_NAME/$BRANCH"
fi

# Output the current branch
echo "Switched to branch '$LOCAL_BRANCH'"
