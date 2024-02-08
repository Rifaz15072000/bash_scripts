#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# EC2 instance details
INSTANCE_ID="i-063acfbd6f3cad74c"

# Reboot the EC2 instance
aws ec2 reboot-instances --instance-ids "$INSTANCE_ID" --region "$AWS_REGION"

# Check for errors in the reboot command
if [ $? -ne 0 ]; then
    echo "Error rebooting EC2 instance: $?"
    exit 1
fi

echo "EC2 instance $INSTANCE_ID is being rebooted."

