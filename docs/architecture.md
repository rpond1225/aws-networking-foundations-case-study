# Architecture

| Property | Value |
|----------|-------|
| Case Study | CAL-001 — AWS Networking Foundations |
| Status | Current |
| Last Updated | 2026-07-15 |

---

# Overview

CAL-001 establishes the foundational AWS networking architecture for the Cloud Architect Lab portfolio.

The implementation creates a secure Virtual Private Cloud (VPC) using Terraform and introduces the core networking components that future case studies will build upon. Rather than deploying application workloads, this case study focuses on constructing a reusable network foundation while demonstrating engineering documentation, validation, and Infrastructure as Code practices.

---

# Architecture Overview

![AWS Networking Architecture](../diagrams/exported/aws-networking-foundations.svg)

---

# Architectural Hierarchy

The deployed architecture follows the standard AWS networking hierarchy.

```text
AWS Account
└── AWS Region (us-east-1)
    └── VPC (10.10.0.0/16)
        ├── Internet Gateway
        └── Availability Zone (us-east-1a)
            ├── Public Subnet (10.10.1.0/24)
            │   ├── Public Route Table
            │   └── Public Web Security Group
            └── Private Subnet (10.10.11.0/24)
                ├── Private Route Table
                └── Private Application Security Group
```

This hierarchy forms the architectural foundation for all future networking case studies.

---

# Network Design

## Virtual Private Cloud

The VPC provides an isolated private network using the CIDR block:

```text
10.10.0.0/16
```

This address space allows future expansion into multiple Availability Zones while maintaining consistent subnet allocation.

---

## Internet Connectivity

An Internet Gateway is attached to the VPC.

Internet access is currently available only to the public subnet through a default route.

The private subnet intentionally has no Internet route.

---

## Public Subnet

The public subnet uses:

```text
10.10.1.0/24
```

Its route table includes:

- Local VPC routing
- Default route (`0.0.0.0/0`) to the Internet Gateway

The subnet currently contains no compute resources.

---

## Private Subnet

The private subnet uses:

```text
10.10.11.0/24
```

Its route table contains only local VPC routing.

No outbound Internet access is currently configured.

This design prepares the environment for a future NAT Gateway.

---

# Security Architecture

Security is enforced using AWS Security Groups.

## Public Web Security Group

Inbound:

- HTTP (80) from the Internet
- HTTPS (443) from the Internet
- SSH (22) from the configured trusted administrator CIDR

Outbound:

- All traffic

---

## Private Application Security Group

Inbound:

- TCP 8080 from the Public Web Security Group

Outbound:

- All traffic

Using a Security Group reference instead of IP-based trust simplifies future scaling and maintains least-privilege communication between application tiers.

---

# Current Deployment

The current implementation includes:

- Amazon VPC
- Internet Gateway
- Public subnet
- Private subnet
- Public route table
- Private route table
- Route table associations
- Public Web Security Group
- Private Application Security Group

The following components are intentionally not yet deployed:

- NAT Gateway
- Bastion Host
- Application Load Balancer
- EC2 instances
- Auto Scaling
- Multiple Availability Zones

---

# Design Decisions

Key architectural decisions include:

- Build a custom VPC rather than using the AWS default VPC.
- Separate public and private network tiers from the beginning.
- Use dedicated route tables for each subnet.
- Use Security Group references between tiers instead of IP allow lists.
- Design Terraform for future multi-Availability Zone expansion using `for_each`.

Additional engineering rationale is documented in:

- `decisions.md`
- `adr/`

---

# Future Evolution

Future Cloud Architect Lab milestones will extend this architecture by introducing:

- Multi-Availability Zone deployment
- NAT Gateway
- Bastion Host
- Application Load Balancer
- EC2 application workloads
- Auto Scaling
- VPC Flow Logs
- Hybrid networking
- VPC Peering

Each milestone will build upon this networking foundation while preserving the overall architectural hierarchy.

---

# Related Documentation

- `deployment.md`
- `validation.md`
- `decisions.md`
- `adr/`