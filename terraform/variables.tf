############################################################
# CAL-001 – Input Variables
#
# Purpose:
# Defines the configurable values consumed by the Terraform
# configuration.
#
# Separating configuration from resource definitions makes
# the infrastructure easier to reuse across environments,
# regions, and future case studies.
############################################################

############################################################
# AWS Deployment Configuration
############################################################

variable "aws_region" {
  description = "AWS Region used for this case study"
  type        = string
}

############################################################
# VPC Configuration
############################################################

variable "vpc_cidr" {
  description = "CIDR block assigned to the case study VPC"
  type        = string
}

############################################################
# Resource Naming and Tagging
############################################################

variable "project_name" {
  description = "Case study identifier used for resource names and tags"
  type        = string
}

############################################################
# Administrative Access
#
# This CIDR should normally represent one trusted public
# IPv4 address using /32 notation.
#
# It is used to restrict SSH access to future public-tier
# resources rather than allowing SSH from the entire
# internet.
############################################################

variable "trusted_ssh_cidr" {
  description = "Trusted CIDR block allowed to SSH into public resources"
  type        = string
}

############################################################
# Availability Zones and Subnet CIDRs
#
# This map defines every Availability Zone participating in
# the VPC and assigns one public and one private subnet CIDR
# to each AZ.
#
# The Availability Zone name is used as the map key:
#
# "us-east-1a" = {
#   public_subnet_cidr  = "10.10.1.0/24"
#   private_subnet_cidr = "10.10.11.0/24"
# }
#
# Additional Availability Zones can be introduced by adding
# entries to terraform.tfvars without duplicating resource
# blocks in main.tf.
############################################################

variable "availability_zones" {
  description = "Availability Zones and subnet CIDR blocks used by the VPC"

  type = map(object({
    public_subnet_cidr  = string
    private_subnet_cidr = string
  }))
}