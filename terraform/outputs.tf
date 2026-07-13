############################################################
# CAL-001 – Terraform Outputs
#
# Purpose:
# Exposes important identifiers after Terraform creates or
# updates the infrastructure.
#
# Outputs support validation, troubleshooting, automation,
# and reuse by future Terraform configurations.
############################################################

############################################################
# VPC Output
############################################################

output "vpc_id" {
  description = "ID of the CAL-001 VPC"
  value       = aws_vpc.main.id
}

############################################################
# Subnet Outputs
#
# Subnet IDs are returned as maps keyed by Availability
# Zone. This allows the output structure to remain unchanged
# when additional Availability Zones are introduced.
#
# Example:
#
# {
#   "us-east-1a" = "subnet-xxxxxxxx"
#   "us-east-1b" = "subnet-yyyyyyyy"
# }
############################################################

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by Availability Zone"

  value = {
    for az, subnet in aws_subnet.public :
    az => subnet.id
  }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by Availability Zone"

  value = {
    for az, subnet in aws_subnet.private :
    az => subnet.id
  }
}

############################################################
# Internet Gateway Output
############################################################

output "internet_gateway_id" {
  description = "ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.main.id
}

############################################################
# Route Table Outputs
#
# Route table IDs are also exposed as Availability Zone
# maps so future validation and automation can identify the
# routing resources belonging to each subnet pair.
############################################################

output "public_route_table_ids" {
  description = "Public route table IDs keyed by Availability Zone"

  value = {
    for az, route_table in aws_route_table.public :
    az => route_table.id
  }
}

output "private_route_table_ids" {
  description = "Private route table IDs keyed by Availability Zone"

  value = {
    for az, route_table in aws_route_table.private :
    az => route_table.id
  }
}