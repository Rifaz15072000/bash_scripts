#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"
INSTANCE_NAME="MyEC2Instance"

# Get the instance ID based on the instance name
instance_id=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_NAME" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text \
    --region "$AWS_REGION")

# Check if the instance ID is empty
if [ -z "$instance_id" ]; then
    echo "Error: Unable to find the instance with name $INSTANCE_NAME."
    exit 1
fi

# Terminate the EC2 instance
termination_result=$(aws ec2 terminate-instances \
    --instance-ids "$instance_id" \
    --output json \
    --region "$AWS_REGION")

# Check for errors in the termination response
if [ $? -ne 0 ]; then
    echo "Error terminating EC2 instance $instance_id: $termination_result"
    exit 1
fi

echo "EC2 instance $instance_id is being terminated."
