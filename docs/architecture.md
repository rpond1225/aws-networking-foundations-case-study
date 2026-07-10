# Architecture

## Purpose

This document describes the architecture of **CAL-001 – AWS Networking Foundations**, including the network topology, design principles, and architectural decisions that establish the baseline for future Cloud Architect Lab case studies.

The objective of this project is to build a secure, repeatable AWS networking foundation using Infrastructure as Code (Terraform) while following cloud architecture best practices.

---

## Solution Overview

The architecture consists of a custom Amazon Virtual Private Cloud (VPC) deployed within a single AWS Region.

The initial implementation establishes the foundational networking components required for future workloads:

- Custom Virtual Private Cloud (VPC)
- Public Subnet
- Internet Gateway
- Route Table
- Network ACL
- Security Group

This networking layer serves as the base upon which future case studies will build additional capabilities, including private subnets, NAT Gateways, EC2 instances, VPC Peering, and multi-AZ architectures.

---

## Design Principles

### Infrastructure as Code

All infrastructure is defined using Terraform and stored in version control. Infrastructure should never rely on manual configuration through the AWS Management Console.

### Architecture as Code

Architecture diagrams are maintained as Mermaid source files and rendered into SVG assets. The diagram source is version-controlled alongside the infrastructure code, ensuring the architecture documentation evolves with the implementation.

### Repeatability

The environment can be recreated consistently from source using Terraform, reducing configuration drift and enabling reproducible deployments.

### Simplicity

The initial architecture intentionally focuses on foundational AWS networking concepts before introducing additional complexity. Each future enhancement builds upon this baseline rather than replacing it.

---

## Architecture Components

### Virtual Private Cloud (VPC)

The VPC provides logical isolation for cloud resources and defines the project's private network boundary.

### Public Subnet

The public subnet hosts resources that require direct internet connectivity through the Internet Gateway.

### Internet Gateway

The Internet Gateway enables communication between resources in the public subnet and the public Internet.

### Route Table

The route table controls network routing within the VPC and directs internet-bound traffic through the Internet Gateway.

### Network ACL

The Network Access Control List (NACL) provides stateless subnet-level traffic filtering.

## Security Groups

This environment uses AWS Security Groups as the primary network access control mechanism. Security Groups are stateful virtual firewalls that control traffic to individual AWS resources.

### Public Web Security Group

The public web security group allows:

- HTTP (TCP 80) from the Internet
- HTTPS (TCP 443) from the Internet
- SSH (TCP 22) only from a trusted administrator IP address
- All outbound traffic

### Private Application Security Group

The private application security group allows:

- TCP port **8080** only from resources associated with the public web security group
- All outbound traffic

Port **8080** was selected because it is a common application port used by web application frameworks such as Apache Tomcat, Spring Boot, and many Java-based services. The specific application is not deployed as part of this case study; instead, the port is used to demonstrate a common multi-tier architecture pattern in which a public-facing web tier communicates securely with a private application tier.

Rather than allowing traffic from an IP address or subnet, the private application security group trusts the **public web security group** itself. This approach allows access to follow application identity rather than network location and is considered a cloud-native security design pattern within AWS.

---

## Network Topology

The current architecture consists of a single VPC containing one public subnet with controlled internet access through an Internet Gateway.

The complete architecture is documented in the following assets:

- Source: `diagrams/source/aws-networking-foundations.mmd`
- Rendered Diagram: `diagrams/exported/aws-networking-foundations.svg`

## Milestone CAL-001.02 — Route Tables

The network architecture now includes dedicated route tables for both the public and private subnets.

The public route table provides internet connectivity by routing outbound traffic through the Internet Gateway. The private route table remains isolated, allowing only local VPC routing at this stage of the project.

Separating routing from subnet design demonstrates an important AWS networking principle: subnets define network boundaries, while route tables determine how traffic is directed within and beyond those boundaries.

This milestone intentionally introduces routing before implementing security groups, network ACLs, or NAT Gateways so that each networking concept can be understood independently.

---

## Architectural Constraints

This project intentionally omits several production-oriented components while focusing on foundational networking concepts.

Current exclusions include:

- Private subnets
- NAT Gateway
- Multiple Availability Zones
- Transit Gateway
- VPN connectivity
- Direct Connect
- Hybrid networking

These capabilities will be introduced in subsequent Cloud Architect Lab case studies.

---

## Relationship to Future Projects

This project establishes the networking foundation for future Cloud Architect Lab implementations.

Planned projects will expand this architecture to include:

- CAL-002 – AWS VPC Peering
- Multi-AZ networking
- EC2 application workloads
- Secure private networking
- Enterprise routing strategies
- Hybrid and multi-cloud connectivity

Each future case study will build upon the architectural patterns established in CAL-001 rather than introducing unrelated designs.