#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define an array of the files and directories to check
files_and_dirs=(.bash_profile .bashrc .inputrc .git_aliases/ .gitconfig .vim/ .vimrc)

# Array to store existing files and directories
exists=()

# Check if each file or directory exists in the root directory
for item in "${files_and_dirs[@]}"; do
    if [[ -e ~/"$item" ]]; then
        exists+=("$item")
    fi
done

# If any file or directory exists, prompt the user for confirmation
if [[ ${#exists[@]} -ne 0 ]]; then
    echo "These files/directories will be replaced: ${exists[@]}"
    read -p "Do you want to continue? (yes/no): " response
    if [[ "$response" != "yes" ]]; then
        echo "Operation aborted."
        exit 1
    fi
fi

# Remove any existing files/directories or symlinks from the user's home directory
for item in "${exists[@]}"; do
    # Check without trailing /
    base_item="${item%/}"

    if [[ -L ~/"$base_item" ]]; then
        # It's a symlink, remove it
        rm ~/"$base_item"
    elif [[ -e ~/"$base_item" ]]; then
        # It's an actual file or directory
        rm -rf ~/"$base_item"
    fi
done

# Create symlinks from the script's current directory to the user's home directory
for item in "${files_and_dirs[@]}"; do
    base_item="${item%/}"
    ln -s "$DIR/$base_item" ~/"$base_item"
done

if [[ -L "$DIR/.vim/colors" ]]; then
    rm "$DIR/.vim/colors"
fi

ln -s "$DIR/.vim/vim-colorschemes/colors" "$DIR/.vim/colors"

echo "Symlinks created successfully."

# Initialise `vim-colorschemes` submodule.
cd "$DIR"
git submodule update --init

git update-index --skip-worktree .bash_profile
echo "Ignored future changes to '.bash_profile'"
