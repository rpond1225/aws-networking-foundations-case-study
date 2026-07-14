# Architecture

## Purpose

This document describes the architecture of **CAL-001 — AWS Networking Foundations**.

The project establishes a secure, repeatable AWS networking baseline using Terraform. The implementation is intentionally small enough to understand and validate clearly, while remaining extensible for future multi-Availability Zone and workload-based case studies.

---

## Solution Overview

CAL-001 deploys a custom Amazon Virtual Private Cloud within a single AWS Region.

The current implementation includes:

- One custom VPC
- One public subnet per configured Availability Zone
- One private subnet per configured Availability Zone
- One Internet Gateway
- One public route table per configured Availability Zone
- One private route table per configured Availability Zone
- Explicit subnet-to-route-table associations
- One public web security group
- One private application security group

The current lab configuration uses a single Availability Zone, but the Terraform design uses a structured map and `for_each` so additional Availability Zones can be added through configuration rather than duplicated resource blocks.

---

## Architecture Diagram

![AWS Networking Architecture](../diagrams/exported/aws-networking-foundations.svg)

Source:

```text
diagrams/source/aws-networking-foundations.mmd
```

Rendered asset:

```text
diagrams/exported/aws-networking-foundations.svg
```

---

## Design Principles

### Infrastructure as Code

All project-managed infrastructure is defined in Terraform and stored in version control.

The AWS Management Console is used for validation and evidence capture, not for making unmanaged configuration changes.

### Architecture as Code

Architecture diagrams are maintained as Mermaid source files and exported as SVG assets.

Keeping diagram source in the repository allows the architecture to evolve alongside the Terraform implementation.

### Repeatability

The environment can be initialized, planned, deployed, validated, and destroyed using a consistent Terraform workflow.

### Incremental Design

The architecture focuses on core AWS networking capabilities before introducing compute, load balancing, managed egress, or inter-VPC connectivity.

### Cost Awareness

The current implementation avoids services with unnecessary recurring cost, such as NAT Gateway, because no private workload currently requires outbound internet access.

---

## Network Topology

### VPC

The VPC defines the private network boundary for the project.

Current lab configuration:

```text
VPC CIDR: 10.10.0.0/16
```

The VPC contains matched public and private subnet pairs for each configured Availability Zone.

### Availability Zone Configuration

Availability Zones and subnet CIDRs are defined using a Terraform map of objects.

Example:

```hcl
availability_zones = {
  "us-east-1a" = {
    public_subnet_cidr  = "10.10.1.0/24"
    private_subnet_cidr = "10.10.11.0/24"
  }
}
```

Terraform uses `for_each` to create the required subnet and route-table resources for every configured Availability Zone.

This design currently deploys one subnet pair but can expand to additional Availability Zones without duplicating infrastructure logic.

---

## Public Subnet Design

Each configured Availability Zone receives one public subnet.

Public subnets:

- Automatically assign public IPv4 addresses to launched resources
- Use a dedicated public route table
- Have a default IPv4 route to the Internet Gateway
- Are intended for future internet-facing resources

A subnet is considered public because its associated route table contains:

```text
0.0.0.0/0 → Internet Gateway
```

The project does not currently deploy EC2 instances or other public workloads.

---

## Private Subnet Design

Each configured Availability Zone receives one private subnet.

Private subnets:

- Do not automatically assign public IPv4 addresses
- Use a dedicated private route table
- Have only the VPC-local route
- Do not have direct internet connectivity

No NAT Gateway is deployed in the current milestone.

This is intentional. Private workloads do not yet exist, and adding managed egress before it is required would increase cost without improving the current learning objective.

---

## Internet Connectivity

The VPC includes one Internet Gateway.

The Internet Gateway is attached to the VPC and referenced by the default route in each public route table.

Attaching an Internet Gateway alone does not make a subnet public. Internet reachability requires all of the following:

- An attached Internet Gateway
- A route-table entry directing external traffic to the gateway
- Association between the route table and the subnet
- Appropriate security controls
- A public IPv4 address on the resource

---

## Route Table Design

### Public Route Tables

One public route table is created for each configured Availability Zone.

Each public route table includes:

- The AWS-managed local VPC route
- A default route to the Internet Gateway

Each public subnet is explicitly associated with the matching public route table for its Availability Zone.

### Private Route Tables

One private route table is created for each configured Availability Zone.

Each private route table includes:

- The AWS-managed local VPC route
- No default internet route

Each private subnet is explicitly associated with the matching private route table for its Availability Zone.

Using explicit associations avoids reliance on the VPC main route table and makes subnet behavior easier to understand, validate, and maintain.

---

## Security Architecture

### Security Groups

Security Groups provide stateful, resource-level traffic control.

The project defines separate security groups for future public and private application tiers.

### Public Web Security Group

The public web security group allows:

- HTTP on TCP port 80 from the internet
- HTTPS on TCP port 443 from the internet
- SSH on TCP port 22 from a trusted administrator CIDR
- All outbound traffic

SSH access is restricted through the `trusted_ssh_cidr` variable rather than opened globally.

No compute resource currently uses this security group. It represents the intended access policy for a future public web tier.

### Private Application Security Group

The private application security group allows:

- TCP port 8080 from resources associated with the public web security group
- All outbound traffic

The rule references the public web security group rather than an IP address or subnet CIDR.

This expresses trust between application tiers and allows resources to be replaced or scaled without changing IP-based firewall rules.

### Network ACLs

The project currently uses the default Network ACL created with the VPC.

Custom Network ACL rules are outside the current scope because the case study focuses on routing, subnet separation, and stateful Security Group design.

---

## Terraform Design

The Terraform implementation separates configuration from infrastructure logic.

### Configuration

The following values are provided through variables:

- AWS Region
- VPC CIDR
- Project name
- Trusted SSH CIDR
- Availability Zones
- Public subnet CIDRs
- Private subnet CIDRs

### Resource Creation

Terraform uses `for_each` across the Availability Zone map to create:

- Public subnets
- Private subnets
- Public route tables
- Private route tables
- Public route-table associations
- Private route-table associations
- Public default routes

This design avoids duplicate resource blocks and supports future multi-AZ expansion.

### Outputs

Terraform exposes:

- VPC ID
- Internet Gateway ID
- Public subnet IDs keyed by Availability Zone
- Private subnet IDs keyed by Availability Zone
- Public route table IDs keyed by Availability Zone
- Private route table IDs keyed by Availability Zone

These outputs support validation, troubleshooting, and reuse by future configurations.

---

## Availability and Reliability

The Terraform design is multi-AZ extensible, but the current lab deployment uses one Availability Zone.

The present implementation should therefore not be described as highly available.

A production-oriented extension would typically add:

- At least two Availability Zones
- Public and private subnet pairs in each Availability Zone
- Redundant application resources
- Load balancing
- Multi-AZ data services
- Availability Zone-aware routing and failure testing

The current design establishes the reusable network pattern required for those capabilities.

---

## Cost Considerations

The deployed components are primarily low-cost or no-additional-charge networking resources.

Potential future cost drivers include:

- NAT Gateway hourly and data-processing charges
- EC2 instances
- Application Load Balancer
- Data transfer
- VPC Flow Logs storage and analysis
- Transit Gateway
- VPN or Direct Connect services

The lab remains intentionally disposable. Resources should be destroyed when validation is complete.

---

## Current Scope

The current implementation includes:

- Custom VPC
- Public subnet
- Private subnet
- Internet Gateway
- Public and private route tables
- Explicit route-table associations
- Public web security group
- Private application security group
- Terraform outputs
- Architecture documentation
- Validation evidence

The current lab configuration deploys these resources in one Availability Zone.

---

## Deferred Capabilities

The following capabilities are intentionally outside the current scope:

- EC2 workloads
- NAT Gateway
- Application Load Balancer
- Auto Scaling
- Multiple deployed Availability Zones
- VPC Flow Logs
- VPC peering
- Transit Gateway
- VPN connectivity
- Direct Connect
- Hybrid networking
- Multi-cloud connectivity

These capabilities belong in later milestones or future Cloud Architect Lab case studies.

---

## Relationship to Future Projects

CAL-001 establishes the network design patterns that future case studies can reuse and extend.

Potential future work includes:

- CAL-002 — VPC peering
- Multi-AZ application architecture
- Public web and private application tiers
- Managed private-subnet egress
- Load balancing and Auto Scaling
- Centralized network inspection
- Hybrid connectivity
- Multi-cloud integration

The primary value of CAL-001 is not only the deployed resources, but the repeatable pattern for designing, implementing, validating, and documenting cloud infrastructure.
