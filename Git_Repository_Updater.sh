#!/usr/bin/bash

# Set the path to the Git repository
repo_path="/home/ubuntu/bash_scripts"

# Navigate to the repository directory
cd "$repo_path" || exit

# Pull changes from the remote repository
git pull

echo "Git repository updated successfully!"
