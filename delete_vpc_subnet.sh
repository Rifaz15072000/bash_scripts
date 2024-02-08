#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# VPC details
VPC_NAME="MyVPC"
VPC_CIDR_BLOCK="10.0.0.0/16"

# Find the VPC ID by name
vpc_id=$(aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=$VPC_NAME" \
    --query "Vpcs[0].VpcId" \
    --output text \
    --region "$AWS_REGION")

# Check if the VPC ID is empty
if [ -z "$vpc_id" ]; then
    echo "Error: Unable to find the VPC with name $VPC_NAME."
    exit 1
fi

echo "VPC ID found: $vpc_id"

# Delete the subnet(s) within the VPC
subnet_ids=$(aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$vpc_id" \
    --query "Subnets[*].SubnetId" \
    --output text \
    --region "$AWS_REGION")

if [ -n "$subnet_ids" ]; then
    echo "Deleting subnets: $subnet_ids"
    aws ec2 delete-subnet --subnet-id $subnet_ids --region "$AWS_REGION"
else
    echo "No subnets found in the VPC."
fi

# Delete the VPC
echo "Deleting VPC: $vpc_id"
aws ec2 delete-vpc --vpc-id "$vpc_id" --region "$AWS_REGION"

echo "VPC and subnet deletion completed."
