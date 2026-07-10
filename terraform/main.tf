resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
  }
}

############################################################
# Security Groups
############################################################
#
# This project currently uses the default Network ACL
# created automatically with the VPC.
#
# Security Groups provide instance-level, stateful
# firewall protection and are the primary access control
# mechanism used in this case study.
#
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

  tags = {
    Name = "${var.project_name}-public-web-sg"
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

}

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
    Name = "${var.project_name}-private-app-sg"
  }
}