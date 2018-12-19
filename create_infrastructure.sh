#!/bin/bash

image_id=ami-09693313102a30b2c
instance_type=t2.micro
vpc_id=vpc-0e4dfd64aef6a44fc
key_name=user7
#security_group=sg-0f0cc75216aa3485b
subnet_id=subnet-0a8edbfe14d168679
shutdown_type=stop
tags="ResourceType=instance,Tags=[{Key=Installation_id,Value=user7-1},{Key=Name,Value=user7-vm1}]"

#$0 - script itself
#$1 - first argument

start()
{
 private_ip_address="10.3.1.71"
  public_ip=associate-public-ip-address

aws ec2 run-instances \
    --image-id "$image_id" \
    --instance-type "$instance_type" \
    --key-name "$key_name" \
    --subnet-id "$subnet_id" \
    --instance-initiated-shutdown-behavior "$shutdown_type" \
    --private-ip-address "$private_ip_address"\
    --tag-specifications "$tags" \
    --${public_ip} 

  #  [--block-device-mappings <value>]
  #  [--placement <value>]
  #  [--user-data <value>]
  #  [--security-groups <value>]

}

stop()
{
  ids=($(
    aws ec2 describe-instances \
    --query 'Reservations[*].Instances[?KeyName==`'$key_name'`].InstanceId' \
    --output text
  ))
  aws ec2 terminate-instances --instance-ids "${ids[@]}"
}

if [ "$1" = start ]; then
  start
elif [ "$1" = stop ]; then
  stop
else cat <<EOF
Usage:

 $0 start|stop
EOF
fi
