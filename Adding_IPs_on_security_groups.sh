#!/usr/bin/bash

# AWS CLI configuration (replace these values with your own)
AWS_ACCESS_KEY="AKIAR7IRDTQZE54PW5NU"
AWS_SECRET_KEY="0Y8OlmNHTV+boOqICZCOaYIBUXdCJ/5HEpyLXAgE"
AWS_REGION="us-east-1"

# Security group details
SECURITY_GROUP_ID="sg-07f398d2eab44193e"
PORT="3000"  # Replace with the port you want to open
CIDR_IPS=("44.202.22.229/32")  # Replace with the desired IP addresses in CIDR format

# Loop through each CIDR IP and authorize ingress
for CIDR_IP in "${CIDR_IPS[@]}"; do
    aws ec2 authorize-security-group-ingress \
        --region "$AWS_REGION" \
        --group-id "$SECURITY_GROUP_ID" \
        --protocol tcp \
        --port "$PORT" \
        --cidr "$CIDR_IP"

    # Check for errors in the security group ingress authorization
    if [ $? -ne 0 ]; then
        echo "Error authorizing ingress for IP $CIDR_IP on port $PORT: $?"
        exit 1
    fi

    echo "Ingress rule added successfully. Port $PORT is now open for IP $CIDR_IP in the security group."
done
