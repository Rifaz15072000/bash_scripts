#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# EC2 instance details
INSTANCE_ID="i-063acfbd6f3cad74c"

# Allocate an Elastic IP
allocation_id=$(aws ec2 allocate-address --domain vpc --region "$AWS_REGION" --query 'AllocationId' --output text)

# Check for errors in the allocation response
if [ $? -ne 0 ]; then
    echo "Error allocating Elastic IP: $?"
    exit 1
fi

echo "Elastic IP allocated successfully. Allocation ID: $allocation_id"

# Associate the Elastic IP with the EC2 instance
aws ec2 associate-address --instance-id "$INSTANCE_ID" --allocation-id "$allocation_id" --region "$AWS_REGION"

# Check for errors in the association response
if [ $? -ne 0 ]; then
    echo "Error associating Elastic IP with EC2 instance: $?"
    exit 1
fi

echo "Elastic IP associated successfully with EC2 instance."

# Optionally, you may want to update your DNS or application settings to use the new Elastic IP.
# Example: Update DNS records or configuration files with the new IP.
