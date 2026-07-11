# CAL-001 – AWS Networking Foundations

> Foundational AWS networking implemented with Terraform using Infrastructure as Code principles.

**Cloud Architect Lab**

*Infrastructure as Code • Architecture as Code*

| Property | Value |
|----------|-------|
| **Project ID** | CAL-001 |
| **Project Name** | AWS Networking Foundations |
| **Status** | In Progress |
| **Primary Cloud** | AWS |
| **Infrastructure as Code** | Terraform |
| **Difficulty** | Foundation |
| **Last Updated** | July 2026 |

---

## Overview

Cloud Architect Lab is a portfolio of architecture-focused engineering case studies that demonstrate Infrastructure as Code, Architecture as Code, and cloud design principles through repeatable, production-inspired implementations.

The project establishes a secure, reusable networking foundation in Amazon Web Services using Terraform. Rather than creating infrastructure manually through the AWS Management Console, every resource is defined as Infrastructure as Code (IaC), making the environment repeatable, version-controlled, and easy to evolve.

This project also serves as the foundation for future case studies, including VPC Peering, Multi-AZ networking, AWS WorkSpaces, and additional enterprise cloud architectures.

---

## Architecture

The current implementation includes:

- Amazon VPC (`10.0.0.0/16`)
- Public Subnet (`10.0.1.0/24`)
- Private Subnet (`10.0.2.0/24`)
- Internet Gateway
- Public Route Table
- Private Route Table
- Network ACL
- Public Web Security Group
- Private Application Security Group

This milestone introduces explicit routing through dedicated public and private route tables. The architecture demonstrates how route tables—not subnets—determine network reachability within a VPC while preparing the environment for future NAT Gateway and multi-tier application deployments.

### Architecture Assets

| Asset | Purpose |
|--------|---------|
| `diagrams/source/aws-networking-foundations.mmd` | Mermaid source (Architecture as Code) |
| `diagrams/exported/aws-networking-foundations.svg` | Rendered architecture diagram |

### Current Architecture

The current implementation includes:

- Amazon VPC (10.0.0.0/16)
- Public subnet
- Private subnet
- Internet Gateway
- Public Route Table
- Private Route Table

This milestone focuses on AWS routing fundamentals by introducing subnet-to-route-table associations while maintaining a simple, easy-to-understand network design.

---

## Repository Structure

```text
.
├── diagrams/
│   ├── source/
│   │   └── aws-networking-foundations.mmd
│   └── exported/
│       └── aws-networking-foundations.svg
├── docs/
│   ├── architecture.md
│   ├── decisions.md
│   ├── deployment.md
│   ├── validation.md
│   ├── lessons-learned.md
│   └── adr/
├── screenshots/
├── terraform/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── .terraform.lock.hcl
│   └── terraform.tfvars.example
├── README.md
└── .gitignore
```

---

## Technologies

- Amazon Web Services (AWS)
- Terraform
- Git
- GitHub
- Mermaid
- Visual Studio Code

---

## Quick Start

Clone the repository:

```bash
git clone <repository-url>
cd aws-networking-foundations
```

Initialize Terraform:

```bash
cd terraform
terraform init
```

Create a local variables file from the example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Review the execution plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

When finished with the lab:

```bash
terraform destroy
```

---

## Documentation

The README provides a high-level overview of the project. Detailed engineering documentation is maintained under the `docs/` directory, where each document serves a specific purpose within the Cloud Architect Lab documentation standard.

| Document | Purpose |
|--------------------|---------|
| `architecture.md` | Overall solution architecture and design |
| `decisions.md` | Key design decisions and architectural tradeoffs |
| `deployment.md` | Deployment procedures and implementation details |
| `validation.md` | Verification and testing of deployed infrastructure |
| `lessons-learned.md` | Engineering observations and future improvements |
| `adr/` | Architecture Decision Records (ADRs) |

---

## Current Status

### Completed

- ✅ CAL-001.01 — Initial VPC Architecture
- ✅ CAL-001.02 — Route Tables
- ✅ Terraform implementation
- ✅ AWS deployment validated
- ✅ Architecture documentation

### In Progress

- 🚧 CAL-001.03 — Security Groups

### Planned

- NAT Gateway
- EC2 workload
- Multi-AZ architecture
- VPC Peering

---

## Next Steps

Upcoming milestones include:

- Security Groups
- EC2 workload deployment
- NAT Gateway
- Multi-AZ architecture
- VPC Peering
- Enterprise routing patterns

---

## Related Projects

- **CAL-000** – Cloud Architect Lab Platform *(planned)*
- **CAL CLI** – Cloud Architect Lab command-line tooling
- **CloudArchitectLab.com** – Portfolio website
- **CAL-002** – AWS VPC Peering *(planned)*

---

Cloud Architect Lab is a portfolio of architecture-focused case studies demonstrating cloud engineering, Infrastructure as Code, and Architecture as Code through repeatable, well-documented implementations.