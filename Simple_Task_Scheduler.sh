#!/usr/bin/bash

# Set the command to be executed
command_to_run="echo 'Hello, world!'"

# Set the schedule using cron syntax (every day at 2:00 AM)
schedule="0 2 * * *"

# Add the scheduled task to the crontab
echo "$schedule $command_to_run" | crontab -

echo "Task scheduled successfully!"
