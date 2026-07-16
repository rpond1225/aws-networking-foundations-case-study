# Deployment

| Property | Value |
|----------|-------|
| Case Study | CAL-001 — AWS Networking Foundations |
| Status | Current |
| Last Updated | 2026-07-15 |

---

# Overview

This document describes the process used to deploy the CAL-001 AWS Networking Foundations environment.

The infrastructure is provisioned using Terraform and is intended to be reproducible, disposable, and version controlled.

---

# Prerequisites

The following software is required:

- AWS CLI
- Terraform
- Git

An AWS account with appropriate permissions is also required.

---

# Deployment Architecture

The current deployment creates:

- Amazon VPC (`10.10.0.0/16`)
- Internet Gateway
- Public subnet (`10.10.1.0/24`)
- Private subnet (`10.10.11.0/24`)
- Public Route Table
- Private Route Table
- Route Table Associations
- Public Web Security Group
- Private Application Security Group

---

# Deployment Process

Clone the repository.

```bash
git clone <repository-url>
cd aws-networking-foundations
```

Initialize Terraform.

```bash
cd terraform

terraform init
```

Review the execution plan.

```bash
terraform plan
```

Deploy the infrastructure.

```bash
terraform apply
```

---

# Verify Deployment

After deployment, verify:

- Terraform completed successfully.
- Expected resources exist in AWS.
- Public route points to the Internet Gateway.
- Security Groups match the documented design.
- Route tables are associated with the correct subnets.

Additional verification procedures are documented in `validation.md`.

---

# Current Limitations

The current implementation intentionally excludes:

- NAT Gateway
- Bastion Host
- EC2 instances
- Application Load Balancer
- Auto Scaling
- Multi-Availability Zone deployment

These components will be introduced in future milestones.

---

# Cleanup

Destroy the environment when finished.

```bash
terraform destroy
```

---

# Related Documentation

- `architecture.md`
- `validation.md`
- `decisions.md`