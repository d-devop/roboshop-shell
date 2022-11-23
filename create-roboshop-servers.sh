#!/bin/bash

### Change these values ###
ZONE_ID="Z03551682VLJ0LWPP9EDP"
SG_NAME="allow-all"
#ENV="dev"
##############################

env=dev

create ec2(){
  PRIVATE_IP=$(aws ec2 run-instances \
      --image-id ${AMI ID} \
      --instance-type t3.micro \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${COMPONENT}}]" \
      --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptBehavior=stop}" \
      --security-group-ids ${SGID} \
      | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')
  exit
}
