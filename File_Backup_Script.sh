
#!/usr/bin/bash

# Set source and destination directories
source_dir="/home/ubuntu/bash_scripts/"
dest_dir="/home/ubuntu/backup_scripts/"

# Create backup directory if it doesn't exist
mkdir -p "$dest_dir"

# Copy files from source to destination
cp -r "$source_dir"/* "$dest_dir"

echo "Backup completed successfully!"
