variable "aws_region" {
  description = "AWS region for this case study"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the case study VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
}

variable "trusted_ssh_cidr" {
  description = "Trusted CIDR block allowed to SSH into public resources"
  type        = string
}