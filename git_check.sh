#!/bin/bash

# Function to display usage instructions
function usage() {
    echo "Usage: $0 <relative_folder_path>"
    exit 1
}

# Function to check out the 'master' branch before exiting
function checkout_master() {
    git checkout master
    echo "Checked out 'master' branch."
    exit 0
}

# Trap the EXIT signal to ensure 'master' branch is checked out before exiting
trap checkout_master EXIT

# Check if a relative folder path is provided as an argument
if [ $# -ne 1 ]; then
    usage
fi

# Get the provided relative folder path
folder_path="$1"

# Verify if the folder exists
if [ ! -d "$folder_path" ]; then
    echo "Error: Folder '$folder_path' does not exist."
    exit 1
fi

# Initialize a variable to store the commit history
commit_log=$(git log --oneline -- "$folder_path")

# Initialize a variable to keep track of the current commit index
current_commit=$(echo "$commit_log" | wc -l)

# Check out the last commit initially
if ((current_commit > 0)); then
    commit_hash=$(echo "$commit_log" | awk "NR==$current_commit {print \$1}")
    git checkout "$commit_hash"
    echo "Checked out commit $commit_hash."
    git reset HEAD~1
    ((current_commit--))
fi

# Prompt the user to choose an action
while true; do
    read -n1 -p "Press 'n' to go to the next commit, 'q' to quit: " action
    echo

    if [[ "$action" == "q" ]]; then
        echo "Exiting."
        break
    elif [[ "$action" == "n" ]]; then
        if ((current_commit <= 0)); then
            echo "No more commits to check out."
        else
            commit_hash=$(echo "$commit_log" | awk "NR==$current_commit {print \$1}")
            git checkout "$commit_hash"
            echo "Checked out commit $commit_hash."
            git reset HEAD~1
            ((current_commit--))
        fi
    else
        echo "Invalid input. Please press 'n' to go to the next commit or 'q' to quit."
    fi
done

