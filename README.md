The purpose of this tutorial is to create 3 identical OpenSUSE LEAP 15.3 virtual machines in AWS that we will deploy only with Ansible.
With the goal of using this infrastrucutre to deploy a kubernetes cluster .

## What is AWS EC2 ?

Amazon Elastic Compute Cloud (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers.

## What is Ansible ?

Ansible is a software tool that provides simple but powerful automation for cross-platform computer support. It is primarily intended for IT professionals, who use it for application deployment, updates on workstations and servers, cloud provisioning, configuration management, intra-service orchestration, and nearly anything a systems administrator does on a weekly or daily basis. Ansible doesn’t depend on agent software and has no additional security infrastructure, so it’s easy to deploy.

## Architecture

We will create 3 VMs :
  - master-node-0
  - worker-node-0
  - worker-node-1

  ![AWS infra, AWS infra](/images/ansibleawsinfra.png)


## Prerequisites

  Before you get started, you’ll need to have these things:
  * Ansible > 4.5.x
  * amazon.aws Ansible module installed (for the installation run this command : **ansible-galaxy collection install amazon.aws** )
  * AWS key-pair [Create a key pair using Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html){:target="_blank" }
  * An AWS account with the IAM permissions
  * A AWS subnet defined
  * AWS CLI : [the AWS CLI Documentation](https://github.com/aws/aws-cli/tree/v2){:target="_blank" }
  * YQ tools installed in your local admin

You can download all the necessary files on this link : <a href="https://github.com/colussim/ansible-aws-k8s" target="github"><img src="/images/github.png" style="height:20px;width:20px;"></a>
or Clone the repository :

**git clone https://github.com/colussim/ansible-aws-k8s.git**
