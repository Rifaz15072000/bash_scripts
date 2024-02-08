#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# VPC details
VPC_NAME="MyVPC"
VPC_CIDR_BLOCK="10.0.0.0/16"

# Create VPC
vpc_id=$(aws ec2 create-vpc \
    --cidr-block "$VPC_CIDR_BLOCK" \
    --output json \
    --region "$AWS_REGION" \
    --query 'Vpc.VpcId' \
    | tr -d '"')

# Check for errors in the VPC creation response
if [ $? -ne 0 ]; then
    echo "Error creating VPC: $vpc_id"
    exit 1
fi

echo "VPC $vpc_id created successfully."

# Add a name tag to the VPC
aws ec2 create-tags \
    --resources "$vpc_id" \
    --tags Key=Name,Value="$VPC_NAME" \
    --region "$AWS_REGION"

# Create subnet within the VPC
subnet_name="MySubnet"
subnet_cidr_block="10.0.0.0/24"

subnet_id=$(aws ec2 create-subnet \
    --vpc-id "$vpc_id" \
    --cidr-block "$subnet_cidr_block" \
    --output json \
    --region "$AWS_REGION" \
    --query 'Subnet.SubnetId' \
    | tr -d '"')

# Check for errors in the subnet creation response
if [ $? -ne 0 ]; then
    echo "Error creating subnet: $subnet_id"
    exit 1
fi

echo "Subnet $subnet_id created successfully."

# Add a name tag to the subnet
aws ec2 create-tags \
    --resources "$subnet_id" \
    --tags Key=Name,Value="$subnet_name" \
    --region "$AWS_REGION"

echo "Script execution completed."

