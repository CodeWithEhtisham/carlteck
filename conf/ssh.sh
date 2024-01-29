#!/bin/bash

# Your AWS instance's public DNS
AWS_DNS="ec2-18-136-200-252.ap-southeast-1.compute.amazonaws.com"

# Username on your instance typically it's "ec2-user" or "ubuntu" or "root"
USERNAME="ubuntu"

# Your ssh private key location
SSH_PRIVATE_KEY_PATH="/home/hamza/Downloads/carl-website.pem"

# SSH into the instance and execute the commands
ssh -i $SSH_PRIVATE_KEY_PATH $USERNAME@$AWS_DNS "./virtual_env.sh"