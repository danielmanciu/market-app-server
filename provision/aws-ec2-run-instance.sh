#!/bin/bash

PROVISION_SCRIPT="file://$(dirname $(realpath "$0"))/aws-ec2-provision.sh"

aws ec2 run-instances \
    --image-id ami-0e86e20dae9224db8 \
    --instance-type t2.micro \
    --key-name default-kp \
    --security-groups marketapp-server-sg \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=market-app-server},{Key=Project,Value=market-app}]' \
    --user-data ${PROVISION_SCRIPT}

