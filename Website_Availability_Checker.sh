#!/usr/bin/bash

# Set the website URL to check (include http:// or https://)
website_url="https://gmail.com"

# Perform a simple HTTP request and check the status code
response=$(curl -Isk "$website_url" | head -n 1 | cut -d ' ' -f2)

if [ "$response" == "200" ] || [ "$response" == "301" ] || [ "$response" == "302" ]; then
    echo "Website is accessible."
else
    echo "Website is not accessible. Status code: $response"
fi
