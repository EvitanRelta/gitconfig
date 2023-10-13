#!/bin/bash

# Define the file paths
TITLE_PATH="README_TITLE.md"
SEPERATOR_PATH="README_SEPERATOR.md"
FOOTER_PATH="README_FOOTER.md"
HELPER_HEADER_PATH="README_HELPER_HEADER.md"
OUTPUT_PATH="../README.md"

# Initialize README.md with title content
cat "$TITLE_PATH" > "$OUTPUT_PATH"

# Function to append docs content to README.md from a specific directory
process_docs() {
    local BASE_DIR="$1"

    # Create an array to hold all folders that contain docs.md
    FOLDERS_WITH_DOCS=()

    # Loop through folders to create an array of folders containing docs.md
    for FOLDER in "$BASE_DIR"/*/; do
        # Check if docs.md exists in the folder
        if [[ -f "$FOLDER/docs.md" ]]; then
            FOLDERS_WITH_DOCS+=("$FOLDER")
        else
            echo "No docs.md found in $FOLDER"
        fi
    done

    # Get the count of folders that contain docs.md
    NUM_FOLDERS=${#FOLDERS_WITH_DOCS[@]}

    # Loop through folders in FOLDERS_WITH_DOCS and append docs.md content followed by the separator to README.md
    for ((i=0; i<$NUM_FOLDERS; i++)); do
        FOLDER=${FOLDERS_WITH_DOCS[i]}
        cat "$FOLDER/docs.md" >> "$OUTPUT_PATH"
        # Check if this is not the last folder to avoid appending separator at the end
        if ((i < NUM_FOLDERS - 1)); then
            cat "$SEPERATOR_PATH" >> "$OUTPUT_PATH"
        fi
    done
}

# Process the main folders
process_docs "."

# Append helper header content to README.md
cat "$HELPER_HEADER_PATH" >> "$OUTPUT_PATH"

# Process the helper function folders
process_docs ".helper_functions"

# Append footer content to README.md
cat "$FOOTER_PATH" >> "$OUTPUT_PATH"
