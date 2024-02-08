#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"
AMI_ID="ami-0c7217cdde317cfec"
INSTANCE_TYPE="t2.micro"
KEY_NAME="devopsoct23"

# EC2 instance details
INSTANCE_NAME="MyEC2Instance"
SECURITY_GROUP_ID="sg-01b39a03e8154faa5"
SUBNET_ID="subnet-0484f8143e9fdc83f"

# Create EC2 instance
instance_info=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type "$INSTANCE_TYPE" \
    --key-name "$KEY_NAME" \
    --security-group-ids "$SECURITY_GROUP_ID" \
    --subnet-id "$SUBNET_ID" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
    --output json \
    --region "$AWS_REGION")

# Check for errors in the response
if [ $? -ne 0 ]; then
    echo "Error creating EC2 instance: $instance_info"
    exit 1
fi

# Extract instance ID from the response
instance_id=$(echo "$instance_info" | jq -r '.Instances[0].InstanceId')

# Check if instance ID is empty
if [ -z "$instance_id" ]; then
    echo "Error extracting instance ID."
    exit 1
fi

echo "EC2 instance $instance_id is being created."

# Wait for the instance to be in 'running' state
aws ec2 wait instance-running --instance-ids "$instance_id" --region "$AWS_REGION"

# Get the public DNS of the new instance
public_dns=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].PublicDnsName' --output text --region "$AWS_REGION")

echo "EC2 instance $instance_id is now running. Public DNS: $public_dns"

