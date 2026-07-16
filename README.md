# CAL-001 — AWS Networking Foundations

> **Cloud Architect Lab Case Study**

CAL-001 establishes the networking foundation for the Cloud Architect Lab portfolio.

This project demonstrates the design, implementation, validation, and documentation of a production-inspired AWS Virtual Private Cloud (VPC) using Terraform. Rather than focusing on deploying application workloads, this case study concentrates on building a reusable networking foundation that future cloud architectures can build upon.

The repository showcases Infrastructure as Code (IaC), Architecture as Code (AaC), enterprise documentation practices, and a repeatable engineering workflow suitable for modern cloud environments.

---

# Architecture at a Glance

![AWS Networking Architecture](diagrams/exported/aws-networking-foundations.svg)

---

# Current Deployment

The current implementation deploys:

- Amazon VPC (`10.10.0.0/16`)
- Internet Gateway
- Public subnet (`10.10.1.0/24`)
- Private subnet (`10.10.11.0/24`)
- Public Route Table
- Private Route Table
- Public Route (0.0.0.0/0 → Internet Gateway)
- Public and Private Route Table Associations
- Public Web Security Group
- Private Application Security Group

The current deployment uses a single Availability Zone (`us-east-1a`). The Terraform configuration is designed to expand to multiple Availability Zones using `for_each` without duplicating infrastructure code.

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

This repository follows Cloud Architect Lab engineering standards, including:

- Infrastructure as Code (IaC)
- Architecture as Code (AaC)
- Documentation as Code
- Validation-first engineering

---

# Validation

Validation included:

- Terraform formatting and validation
- Successful infrastructure deployment
- Terraform state verification
- AWS Management Console verification
- Architecture review against the deployed environment

Complete validation evidence is available in:

**`docs/validation.md`**

---

# Key Design Decisions

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