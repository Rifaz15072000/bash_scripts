#!/usr/bin/bash

# Set the website URL to check
website_url="google.com"

# Perform a simple HTTP request and check the status code
response=$(curl -Is "$website_url" | head -n 1 | cut -d ' ' -f2)

if [ "$response" == "200" ]; then
    echo "Website is accessible."
else
    echo "Website is not accessible. Status code: $response"
fi
