# Architecture

## Purpose

This document describes the architecture of **CAL-001 – AWS Networking Foundations**, including the network topology, design principles, and architectural decisions that establish the baseline for future Cloud Architect Lab case studies.

The objective of this project is to build a secure, repeatable AWS networking foundation using Infrastructure as Code (Terraform) while following cloud architecture best practices.

---

## Solution Overview

The architecture consists of a custom Amazon Virtual Private Cloud (VPC) deployed within a single AWS Region.

The current implementation establishes the foundational network security architecture required for future workloads.

Terraform currently manages:

- Custom Virtual Private Cloud (VPC)
- Public Web Security Group
- Private Application Security Group

AWS automatically provides several default networking components as part of the VPC, including the main route table, default Network ACL, and default security group. These resources are not explicitly managed by Terraform during this milestone.

This foundation will support future milestones introducing subnets, Internet Gateway, custom route tables, NAT Gateway, EC2 workloads, VPC peering, and multi-AZ architectures.

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

### AWS Default Networking Components

Creating a VPC automatically provisions several default networking resources, including:

- Main Route Table
- Default Network ACL
- Default Security Group

These resources currently remain under AWS default management and are intentionally not replaced during this milestone.

Future milestones will introduce Terraform-managed subnets, Internet Gateway, route tables, route table associations, and additional networking components as the architecture evolves.

### Security Groups

This environment uses AWS Security Groups as the primary instance-level network access control mechanism. Security Groups are stateful virtual firewalls that control traffic to individual AWS resources.

#### Public Web Security Group

The public web security group allows:

- HTTP (TCP 80) from the Internet
- HTTPS (TCP 443) from the Internet
- SSH (TCP 22) only from a trusted administrator IP address
- All outbound traffic

#### Private Application Security Group

The private application security group allows:

- TCP port **8080** only from resources associated with the public web security group
- All outbound traffic

Port **8080** was selected because it is a common application port used by web application frameworks such as Apache Tomcat, Spring Boot, and many Java-based services. The specific application is not deployed as part of this case study; instead, the port is used to demonstrate a common multi-tier architecture pattern in which a public-facing web tier communicates securely with a private application tier.

Rather than allowing traffic from an IP address or subnet, the private application security group trusts the **public web security group** itself. This approach allows access to follow application identity rather than network location and is considered a cloud-native security design pattern within AWS.

---

## Design Considerations

### Security, Availability, and Cost Tradeoffs

The architecture separates public-facing and internal resources into distinct network boundaries. As future milestones introduce public and private subnets, public-facing resources will use routing through an Internet Gateway only when external connectivity is required, while private resources will remain isolated from direct internet access. This layered approach reduces the externally accessible attack surface and establishes a clear security boundary between internet-facing and internal application resources.

This foundational implementation intentionally prioritizes simplicity, repeatability, and cost control over production-level availability. The initial architecture is designed to demonstrate core AWS networking concepts while minimizing unnecessary complexity and ongoing AWS costs.

As the project evolves, production-oriented capabilities such as multiple Availability Zones, redundant networking paths, and managed egress services will be introduced incrementally. This phased approach allows each architectural enhancement to be implemented, validated, and documented independently while preserving a clear learning progression.

Where production environments commonly use components such as a NAT Gateway to provide outbound internet access for private workloads, those services are intentionally deferred until they become necessary for the implementation. This keeps the learning environment focused on the networking concepts introduced in each milestone while avoiding unnecessary recurring infrastructure costs.

---

## Network Topology

The current architecture consists of a dedicated Amazon VPC containing two Terraform-managed Security Groups that establish the project's initial network security boundaries.

At this milestone, no subnets, Internet Gateway, custom route tables, NAT Gateway, or compute resources have been deployed. The architecture focuses on establishing reusable security policies before introducing workload-specific infrastructure.

AWS default networking components—including the main route table, default Network ACL, and default security group—exist as part of the VPC but are not explicitly managed through Terraform during this milestone.

The complete architecture is documented in the following assets:

- Source: `diagrams/source/aws-networking-foundations.mmd`
- Rendered Diagram: `diagrams/exported/aws-networking-foundations.svg`

---

## Current Implementation Scope

This project intentionally omits several production-oriented components while focusing on foundational networking concepts.

Current exclusions include:

- NAT Gateway
- EC2 workloads
- Multiple Availability Zones
- Transit Gateway
- VPN connectivity
- Direct Connect
- Hybrid networking

These capabilities will be introduced in future milestones of CAL-001 and in subsequent Cloud Architect Lab case studies, as appropriate.

---

## Future Evolution

The networking foundation established in this milestone is intentionally minimal and serves as the baseline for future Cloud Architect Lab case studies.

Planned enhancements include:

- Public subnet
- Private subnet
- Internet Gateway
- Custom route tables
- Route table associations
- NAT Gateway
- EC2 workloads
- Multi-AZ networking
- VPC peering

Each enhancement will be introduced as an incremental milestone, allowing the architecture, Infrastructure as Code, validation evidence, and documentation to evolve together.

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