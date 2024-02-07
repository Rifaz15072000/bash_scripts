#!/usr/bin/bash

# Set the threshold for available disk space in MB
threshold_mb=1000

# Get available disk space
available_space=$(df -m / | awk 'NR==2 {print $4}')

# Check if available space is below the threshold
if [ "$available_space" -lt "$threshold_mb" ]; then
    echo "Low disk space! Available space: ${available_space}MB"
else
    echo "Disk space is sufficient."
fi
