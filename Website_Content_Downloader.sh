/home/ubuntu/bash_scripts/rsult
#!/bin/bash

# Set the URL of the website to download
website_url="http://google.com"

# Set the destination directory for downloaded content
download_dir="/home/ubuntu/bash_scripts/rename"

# Use wget to recursively download the website content
wget -r -np -P "$download_dir" "$website_url"

echo "Website content downloaded successfully!"

