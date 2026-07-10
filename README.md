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

AWS Networking Foundations is the first technical case study in the Cloud Architect Lab portfolio.

The project establishes a secure, reusable networking foundation in Amazon Web Services using Terraform. Rather than creating infrastructure manually through the AWS Management Console, every resource is defined as Infrastructure as Code (IaC), making the environment repeatable, version-controlled, and easy to evolve.

This project also serves as the foundation for future case studies, including VPC Peering, Multi-AZ networking, AWS WorkSpaces, and additional enterprise cloud architectures.

---

## Architecture

The environment currently includes:

- Virtual Private Cloud (VPC)
- Public Subnet
- Internet Gateway
- Route Table
- Network ACL
- Security Group

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

Additional project documentation is located in the `docs/` directory.

| Document           | Purpose |
|--------------------|---------|
| `architecture.md` | Overall solution architecture and design |
| `decisions.md` | Key design decisions and architectural tradeoffs |
| `deployment.md` | Deployment procedures and implementation details |
| `validation.md` | Verification and testing of deployed infrastructure |
| `lessons-learned.md` | Engineering observations and future improvements |
| `adr/` | Architecture Decision Records (ADRs) |

---

## Current Status

- ✅ Repository structure established
- ✅ Documentation standards implemented
- ✅ Terraform project initialized
- ✅ AWS networking foundation successfully deployed
- 🚧 Documentation refinement in progress
- 🚧 Additional networking components planned

---

## Next Steps

Planned enhancements include:

- Private subnet implementation
- Multi-AZ architecture
- NAT Gateway
- Additional route tables
- Expanded security groups
- EC2 workload deployment
- VPC Peering
- Enhanced validation documentation

---

## Related Projects

- **CAL-000** – Cloud Architect Lab Platform *(planned)*
- **CAL CLI** – Cloud Architect Lab command-line tooling
- **CloudArchitectLab.com** – Portfolio website
- **CAL-002** – AWS VPC Peering *(planned)*

---

Cloud Architect Lab is a portfolio of architecture-focused case studies demonstrating cloud engineering, Infrastructure as Code, and Architecture as Code through repeatable, well-documented implementations.