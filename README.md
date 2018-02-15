# A COMPLETE AWS ENVIRONMENT WITH TERRAFORM and Ansible
Author: Sam Rogers
2017

WORK IN PROGRESS

The goal of this project is to  create a configurable AWS VPC project 
that allows provisioning a Nodejs web stack with Load Balancer service


## Terraform

Below is a list of the Terraform modules.

  1. vpc-network.tf	
    - Setting up the primary VPC.
  2. routing-and-network.tf
    - Setting up the:
	Internet Gateway
	Network ACL
	Route Table
  3. subnets.tf
    -  Setting up the:
	Subnet
	Route Table Association
  4. securitygroups.tf:
    -  Setting up the:
	Security Groups
  5. ec2-machines.tf:
    -  Setting up the:
	Create EC2 Instance(s)
		create or add to aws_hosts file as the instance get created.
	Run Ansible playbook
	    ansible-playbook -vvvv -i aws_hosts  ansible/playbook-nodejs.py

To Do list

  1. load-balancer.tf
  1. autoscaling.tf	
  
## Playbooks available

This Ansible Playbook has two roles:
- name: Base states
  hosts: web
  become: yes 
  roles:
    - role: repo-epel 
    - role: nodejs

 - repo-epel.yml = Add the epel extras repo for the installs in the nodejs.
 - nodejs.yml = Yum Install, configure and start:
    -  Nginx
    -  Nodejs
    -  Npm
    -  Pm2
