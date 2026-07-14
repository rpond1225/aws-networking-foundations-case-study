# CAL-001 — AWS Networking Foundations

> **Cloud Architect Lab Case Study**

CAL-001 establishes the networking foundation for the Cloud Architect Lab portfolio.

This project demonstrates the design, implementation, validation, and documentation of a production-inspired AWS Virtual Private Cloud (VPC) using Terraform. Rather than focusing on deploying application workloads, this case study concentrates on building a reusable networking foundation that future cloud architectures can build upon.

The repository showcases Infrastructure as Code (IaC), Architecture as Code (AaC), enterprise documentation practices, and a repeatable engineering workflow suitable for modern cloud environments.

---

# Architecture at a Glance

![AWS Networking Architecture](diagrams/exported/aws-networking-foundations.svg)

---

# Technical Highlights

This project demonstrates:

- Terraform-managed AWS networking infrastructure
- Custom Amazon VPC
- Public and private subnet architecture
- Internet Gateway
- Public and private route tables
- Explicit route table associations
- Tier-based Security Group design
- Multi-Availability Zone extensible Terraform design using `for_each`
- Architecture Decision Records (ADRs)
- Validation evidence captured from AWS
- Enterprise engineering documentation
- Disposable Infrastructure as Code lab environments

---

# Why This Project Exists

CAL-001 is more than a Terraform exercise.

Its purpose is to establish the engineering patterns, networking architecture, documentation standards, validation methodology, and reusable Terraform design that future Cloud Architect Lab case studies will build upon.

The emphasis is not simply on deploying AWS resources, but on demonstrating the engineering discipline used to design, implement, validate, and document cloud infrastructure.

---

# Current Architecture

The current implementation deploys:

- Custom Amazon VPC
- Public subnet
- Private subnet
- Internet Gateway
- Public Route Table
- Private Route Table
- Route Table Associations
- Public Web Security Group
- Private Application Security Group

The current lab deployment uses a single Availability Zone while the Terraform configuration is designed to expand to multiple Availability Zones through configuration rather than duplicated infrastructure code.

---

# Repository Structure

```text
aws-networking-foundations/
├── diagrams/
│   ├── exported/
│   └── source/
├── docs/
│   ├── adr/
│   ├── architecture.md
│   ├── decisions.md
│   ├── deployment.md
│   ├── lessons-learned.md
│   └── validation.md
├── screenshots/
├── terraform/
└── README.md
```

---

# Repository Documentation

| Document | Purpose |
|-----------|---------|
| `docs/architecture.md` | Overall solution architecture and networking design |
| `docs/deployment.md` | Terraform deployment workflow |
| `docs/validation.md` | Infrastructure validation and AWS verification |
| `docs/decisions.md` | Significant engineering and architecture decisions |
| `docs/adr/` | Architecture Decision Records |
| `docs/lessons-learned.md` | Technical retrospective and future improvements |

---

# Engineering Practices

This repository follows several engineering principles that are applied consistently throughout Cloud Architect Lab.

- Infrastructure as Code (IaC)
- Architecture as Code (AaC)
- Documentation as Code
- Validation-first engineering
- Git-based engineering workflow
- Disposable cloud environments
- Privacy-first portfolio design

---

# Validation

The deployed infrastructure was validated through:

- Terraform formatting and validation
- Terraform execution plan review
- Successful infrastructure deployment
- Terraform state verification
- AWS Management Console verification
- Architecture comparison
- Documentation review

Validation evidence includes:

- AWS Resource Map
- VPC configuration
- Internet Gateway
- Public and private subnets
- Route tables
- Security Groups

Complete validation details are available in:

**`docs/validation.md`**

---

## Key Design Decisions

Notable architectural decisions include:

- Build a custom VPC instead of using the AWS default VPC.
- Implement all infrastructure using Terraform.
- Maintain architecture diagrams as version-controlled Mermaid source.
- Build the environment through incremental, validated milestones.
- Separate engineering documentation by responsibility.
- Use Security Group references instead of IP-based trust between application tiers.
- Design Terraform for future multi-Availability Zone expansion using `for_each`.
- Use AWS Security Groups as the primary access-control mechanism while intentionally deferring custom Network ACLs until additional compliance or segmentation requirements justify them.

Detailed rationale is documented in:

- `docs/decisions.md`
- `docs/adr/ADR-001-structured-availability-zones.md`

---

# Technologies

- Amazon Web Services (AWS)
- Amazon VPC
- Internet Gateway
- Route Tables
- Security Groups
- Terraform
- Git
- GitHub
- Mermaid
- LatixEngine

---

# Roadmap

The networking foundation established in CAL-001 is designed to support progressively more advanced cloud architecture case studies.

Planned milestones include:

- Multi-Availability Zone deployment
- NAT Gateway
- Bastion Host
- EC2 Web Tier
- Private Application Tier
- Application Load Balancer
- Auto Scaling
- VPC Flow Logs
- VPC Peering
- Transit Gateway
- Hybrid networking
- Multi-cloud connectivity

---

# Learning Outcomes

This project demonstrates practical experience with:

- AWS networking architecture
- Infrastructure as Code using Terraform
- Network segmentation
- Route table design
- Security Group architecture
- Cloud infrastructure validation
- Architecture documentation
- Git-based engineering workflows
- Enterprise cloud engineering practices

---

# Related Cloud Architect Lab Projects

CAL-001 establishes the networking foundation for future Cloud Architect Lab case studies.

Planned projects include:

- CAL-002 — AWS VPC Peering
- Multi-Availability Zone Networking
- EC2 Application Architecture
- Load Balancing and Auto Scaling
- Hybrid Connectivity
- AWS and Snowflake Integration
- Multi-cloud Architecture

---

# Author

**R.P.**

Cloud Architect Lab

Building practical cloud and AI architecture through real-world engineering case studies.