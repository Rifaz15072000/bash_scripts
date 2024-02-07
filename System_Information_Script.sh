#!/usr/bin/bash

# Display system information
echo "System Information:"
echo "-------------------"
echo "Hostname: $(hostname)"
echo "Kernel Version: $(uname -r)"
echo "CPU Info: $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | sed 's/^[ \t]*//')"
echo "Memory: $(free -h | awk 'NR==2 {print $2}')"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')"
