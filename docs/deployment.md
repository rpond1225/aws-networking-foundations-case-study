# Deployment

## Purpose

This document describes the deployment process for **CAL-001 – AWS Networking Foundations**.

The objective is to provide a repeatable, validation-driven deployment process that provisions the AWS networking infrastructure entirely through Infrastructure as Code (Terraform).

This deployment procedure reflects the Cloud Architect Lab engineering workflow and is intended to be reused across future case studies.

---

# Deployment Prerequisites

Before deploying this project, ensure the following prerequisites are met:

- AWS account with appropriate permissions
- AWS CLI installed and authenticated
- Terraform installed
- Git installed
- Visual Studio Code (recommended)

Verify the local environment:

```bash
aws --version
terraform --version
git --version
```

---

# Deployment Workflow

The deployment follows the standard Cloud Architect Lab engineering workflow.

```
Edit Terraform
        │
        ▼
terraform fmt
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform plan -out=<planfile>
        │
        ▼
Review Plan
        │
        ▼
terraform apply <planfile>
        │
        ▼
Terraform Validation
        │
        ▼
AWS Console Validation
        │
        ▼
Documentation Updates
        │
        ▼
Git Commit
```

Each phase is completed before proceeding to the next.

---

# Initialize Terraform

From the project Terraform directory:

```bash
cd terraform
terraform init
```

Terraform downloads the required AWS provider plugins and initializes the working directory.

---

# Format the Configuration

Before validating or deploying infrastructure, ensure all Terraform files follow the standard formatting.

```bash
terraform fmt
```

This promotes consistency across the repository and reduces unnecessary formatting changes in Git.

---

# Validate the Configuration

Validate the Terraform configuration before generating an execution plan.

```bash
terraform validate
```

Terraform should report:

```text
Success! The configuration is valid.
```

---

# Review the Execution Plan

Generate an execution plan to review all proposed infrastructure changes.

```bash
terraform plan
```

Review the plan carefully before deployment.

Confirm that only the intended infrastructure changes will occur.

---

# Save the Deployment Plan

Once the execution plan has been reviewed, save it for deployment.

```bash
terraform plan -out=cal-001.tfplan
```

Saving the plan ensures the reviewed deployment is the exact deployment that will be applied.

---

# Deploy Infrastructure

Deploy the reviewed execution plan.

```bash
terraform apply cal-001.tfplan
```

Terraform provisions the AWS networking resources defined within the project.

---

# Post-Deployment Validation

After deployment, verify the infrastructure using Terraform.

```bash
terraform output
```

```bash
terraform state list
```

Run one final plan.

```bash
terraform plan
```

Terraform should report:

> No changes. Your infrastructure matches the configuration.

---

# AWS Console Validation

Verify the deployed resources within the AWS Management Console.

Current infrastructure includes:

- VPC
- Internet Gateway
- Public Subnet
- Private Subnet
- Public Route Table
- Private Route Table
- Route Table Associations
- Public Web Security Group
- Private Application Security Group

Validation evidence is documented in:

**docs/validation.md**

---

# Infrastructure Destruction

Cloud Architect Lab uses disposable lab environments.

When the environment is no longer required:

```bash
terraform destroy
```

Destroying unused infrastructure:

- Minimizes AWS costs
- Prevents configuration drift
- Ensures future deployments begin from a known baseline

---

# Future Automation

The deployment workflow will progressively become automated through the Cloud Architect Lab CLI (CAL CLI).

Planned automation includes:

- Environment validation
- Terraform formatting
- Terraform validation
- Deployment plan generation
- Deployment approval workflow
- Diagram rendering
- Documentation validation
- Repository validation
- Website publishing
- LinkedIn publishing

---

# Deployment Summary

The CAL-001 deployment process emphasizes:

- Infrastructure as Code
- Repeatable deployments
- Validation before and after deployment
- Documentation alongside implementation
- Disposable lab environments
- Enterprise engineering practices

Each future Cloud Architect Lab case study will follow this same deployment methodology.