#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# Security group details
SECURITY_GROUP_ID="sg-01b39a03e8154faa5"
NEW_PORT="25"  # Replace with the port you want to open
CIDR_IP="0.0.0.0/0"  # Replace with the CIDR range you want to allow access from

# Authorize ingress for the new port
aws ec2 authorize-security-group-ingress \
    --region "$AWS_REGION" \
    --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp \
    --port "$NEW_PORT" \
    --cidr "$CIDR_IP"

# Check for errors in the security group ingress authorization
if [ $? -ne 0 ]; then
    echo "Error authorizing ingress for port $NEW_PORT: $?"
    exit 1
fi

echo "Ingress rule added successfully. Port $NEW_PORT is now open in the security group."
