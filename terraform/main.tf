############################################################
# CAL-001 – AWS Networking Foundations
#
# Purpose:
# Defines the AWS networking resources created during this
# case study.
#
# The configuration is designed to remain readable,
# reusable, and expandable as later milestones introduce
# additional Availability Zones and workloads.
############################################################

############################################################
# Virtual Private Cloud
#
# The VPC establishes the private network boundary for the
# case study. All subnets, route tables, security groups,
# and future workloads are created inside this VPC.
############################################################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
  }
}

############################################################
# Public Subnets
#
# One public subnet is created in each Availability Zone
# configured in terraform.tfvars.
#
# A public subnet automatically assigns public IPv4
# addresses to resources launched within it. Internet
# connectivity still also requires an Internet Gateway,
# an appropriate route, and permissive security controls.
#
# No compute resources are deployed during this milestone.
############################################################

resource "aws_subnet" "public" {
  # Create one subnet for every Availability Zone defined
  # in the availability_zones variable.
  for_each = var.availability_zones

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  # Retrieve the public subnet CIDR assigned to this
  # Availability Zone in terraform.tfvars.
  cidr_block = each.value.public_subnet_cidr

  # Resources launched in this subnet may automatically
  # receive a public IPv4 address.
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-public-${each.key}-subnet"
    Project = var.project_name
    Tier    = "public"
  }
}

############################################################
# Private Subnets
#
# One private subnet is created in each configured
# Availability Zone.
#
# Resources launched in a private subnet do not
# automatically receive public IPv4 addresses. The subnet
# also has no direct route to the Internet Gateway.
#
# A future milestone may add managed outbound connectivity,
# such as a NAT Gateway, when private workloads require it.
############################################################

resource "aws_subnet" "private" {
  # Use the same Availability Zone map as the public
  # subnets so that each AZ receives a matched public and
  # private subnet pair.
  for_each = var.availability_zones

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  # Retrieve the private subnet CIDR assigned to this
  # Availability Zone in terraform.tfvars.
  cidr_block = each.value.private_subnet_cidr

  # Private subnet resources should not automatically
  # receive public IPv4 addresses.
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project_name}-private-${each.key}-subnet"
    Project = var.project_name
    Tier    = "private"
  }
}

############################################################
# Internet Gateway
#
# The Internet Gateway provides a path between the VPC and
# the public internet.
#
# Attaching an Internet Gateway alone does not make a
# subnet public. A subnet must also be associated with a
# route table containing a default route to this gateway.
############################################################

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
  }
}

############################################################
# Public Route Tables
#
# One public route table is created for each configured
# Availability Zone.
#
# Each public route table receives a default route through
# the Internet Gateway and is explicitly associated with
# the matching public subnet.
############################################################

resource "aws_route_table" "public" {
  for_each = var.availability_zones

  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}-public-${each.key}-rt"
    Project = var.project_name
    Tier    = "public"
  }
}

resource "aws_route" "public_default_route" {
  for_each = var.availability_zones

  # Match each route to the public route table created for
  # the same Availability Zone.
  route_table_id = aws_route_table.public[each.key].id

  # Send all non-local IPv4 traffic to the Internet Gateway.
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  for_each = var.availability_zones

  # Explicitly associate each public subnet with the route
  # table created for the same Availability Zone.
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

############################################################
# Private Route Tables
#
# One private route table is created for each configured
# Availability Zone and associated with its matching
# private subnet.
#
# AWS automatically adds the VPC-local route to every route
# table. No internet default route is added here, so private
# subnets remain isolated from direct internet access.
############################################################

resource "aws_route_table" "private" {
  for_each = var.availability_zones

  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}-private-${each.key}-rt"
    Project = var.project_name
    Tier    = "private"
  }
}

resource "aws_route_table_association" "private" {
  for_each = var.availability_zones

  # Associate each private subnet with the private route
  # table created for the same Availability Zone.
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

############################################################
# Security Groups
#
# This project currently uses the default Network ACL
# created automatically with the VPC.
#
# Security Groups provide resource-level, stateful
# firewall protection and are the primary access-control
# mechanism demonstrated in this case study.
############################################################

############################################################
# Public Web Security Group
#
# This security group represents the access policy for a
# future public-facing web tier.
#
# HTTP and HTTPS are allowed from the internet. SSH is
# restricted to the trusted administrator CIDR configured
# in terraform.tfvars.
############################################################

resource "aws_security_group" "public_web_sg" {
  name        = "${var.project_name}-public-web-sg"
  description = "Allow SSH, HTTP, and HTTPS access to public resources"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from trusted CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.trusted_ssh_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-public-web-sg"
    Project = var.project_name
    Tier    = "public"
  }
}

############################################################
# Private Application Security Group
#
# This security group represents the access policy for a
# future private application tier.
#
# Application traffic on TCP port 8080 is allowed only from
# resources associated with the public web security group.
#
# Referencing another security group establishes access
# based on workload identity rather than a fixed IP address.
############################################################

resource "aws_security_group" "private_app_sg" {
  name        = "${var.project_name}-private-app-sg"
  description = "Security group for private application resources"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow application traffic from public web tier"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-private-app-sg"
    Project = var.project_name
    Tier    = "private"
  }
}