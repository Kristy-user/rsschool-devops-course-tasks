# Terraform AWS VPC Setup

## Overview

This Terraform project provisions the following infrastructure in AWS:

- A VPC with CIDR block `10.0.0.0/16`.
- Two public subnets in different Availability Zones.
- Two private subnets in different Availability Zones.
- An Internet Gateway attached to the VPC.
- Route tables configured for public and private subnets.
- A NAT Gateway in a public subnet for private subnet internet access.
- Security Groups configured for the Bastion Host and internal communication.
- Network ACLs allowing traffic between subnets and to/from the internet.
- A Bastion Host in a public subnet for secure SSH access to private instances.

---

## Architecture Overview

- Instances in public subnets have direct internet access via the Internet Gateway.
- Instances in private subnets access the internet through the NAT Gateway.
- The Bastion Host resides in a public subnet with SSH access restricted to your IP address.
- Instances in private subnets can be accessed securely via the Bastion Host.

---

## Prerequisites

- AWS account with permissions to create VPCs, subnets, gateways, route tables, EC2 instances, security groups, and related resources.
- Terraform installed (version 1.0 or higher recommended).
- Update variables in `variables.tf` as needed:
   - `aws_region`: AWS region to deploy resources (default: `us-east-1`).
   - `ssh_key_name`: Your existing EC2 key pair name for SSH access.
   - `my_ip`: Your public IP address in CIDR notation (e.g., `x.x.x.x/32`) to restrict SSH access to the Bastion Host.
   - CIDR blocks and Availability Zones for public and private subnets.

---

## Usage

From the CLI, run:

```bash
terraform plan
terraform apply
```

Or use rerraform.yml in CI/CD 