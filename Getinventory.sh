#!/bin/bash
#
#
#
#  @project     AWS Ansible
#  @package     Getinventory
#  @subpackage
#  @access
#  @paramtype
#  @argument
#  @description Get PrivateIpAddress, PublicIpAddress and PrivateDnsName for each instance : MAster and Worker
#
#  @author Emmanuel COLUSSI
#  @version 1.00

# --------- Read Ansible config file for Role EC2 ---------

# Read variable for Master
cluster_tag=`yq e '.cluster_tag' roles/ec2/vars/main.yml`
master_tag=`yq e '.master_tag' roles/ec2/vars/main.yml`

# Read variable for Workers
workers_tag=` yq e '.workers_tag' roles/ec2/vars/main.yml| awk -F '- ' '{print $2}'`

#----------------------------------------------------------#

# Get values for Master
content_master=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${cluster_tag}" "Name=tag:Name,Values=${master_tag}")
Master01_ip_private=$( jq -r '.Reservations[].Instances[].PrivateIpAddress' <<< "${content_master}" )
Master01_private_name=$( jq -r '.Reservations[].Instances[].PrivateDnsName' <<< "${content_master}"|awk -F '.' '{print $1}')
Master01_ip_public=$( jq -r '.Reservations[].Instances[].PublicIpAddress' <<< "${content_master}" )

printf "%s $master_tag Private Name: $Master01_private_name - Private IP: $Master01_ip_private - $i Public IP: $Master01_ip_public\n"


# Get values for Worker
for i in $workers_tag
do
  content_worker=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${cluster_tag}" "Name=tag:Name,Values=${i}")
  Worker_ip_private=$( jq -r '.Reservations[].Instances[].PrivateIpAddress' <<< "${content_worker}" )
  Worker_private_name=$( jq -r '.Reservations[].Instances[].PrivateDnsName' <<< "${content_worker}"|awk -F '.' '{print $1}')
  Worker_ip_public=$( jq -r '.Reservations[].Instances[].PublicIpAddress' <<< "${content_worker}" )

  printf "%s $i Private Name: $Worker_private_name - Private IP: $Worker_ip_private - $i Public IP: $Worker_ip_public\n"
done
