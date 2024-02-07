#!/usr/bin/bash

# Set the directory containing files to be renamed
dir="/home/ubuntu/bash_scripts/rename"

# Ensure the directory exists
if [ -d "$dir" ]; then
    # Change ownership of the files to the current user
    chown -R ubuntu:ubuntu "$dir"

    # Iterate through files in the directory and rename them
    for file in "$dir"/*; do
        new_name="$dir/rifaz_$(basename "$file")"
        mv "$file" "$new_name"
    done

    echo "Files renamed successfully!"
else
    echo "Error: Directory $dir does not exist."
fi

