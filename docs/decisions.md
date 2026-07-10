# Design Decisions

## Purpose

This document records the significant architectural decisions made during the design and implementation of **CAL-001 – AWS Networking Foundations**.

Rather than documenting every implementation detail, this document explains the rationale behind key design choices and the tradeoffs that influenced them. More formal or long-lived decisions may also be captured as individual Architecture Decision Records (ADRs) within the `docs/adr/` directory.

---

## Decision 1 — Create a Custom VPC

### Decision

Deploy a dedicated Virtual Private Cloud rather than using the default VPC provided by AWS.

### Rationale

Although AWS automatically creates a default VPC in each Region, production environments commonly use custom VPCs to provide complete control over IP addressing, subnet design, routing, and security boundaries.

Building a custom VPC also mirrors enterprise cloud practices and provides a clean foundation for future expansion.

---

## Decision 2 — Build with Infrastructure as Code

### Decision

Provision all infrastructure using Terraform.

### Rationale

Infrastructure as Code provides repeatability, version control, peer review, and consistent deployments. It also minimizes configuration drift by ensuring infrastructure is recreated from source rather than manually configured.

---

## Decision 3 — Document Architecture as Code

### Decision

Maintain architecture diagrams as Mermaid source files and generate SVG diagrams for documentation.

### Rationale

Treating architecture diagrams as source artifacts ensures that architectural documentation evolves alongside the infrastructure code. Version-controlled diagrams also support collaboration, change tracking, and automated publishing workflows.

---

## Decision 4 — Keep the Initial Architecture Intentionally Simple

### Decision

Begin with a minimal networking implementation before introducing advanced networking components.

### Rationale

Establishing a clear and well-understood foundation simplifies troubleshooting and provides a stable baseline for future enhancements such as private subnets, NAT Gateways, multi-AZ deployments, and VPC peering.

---

## Decision 5 — Separate Repository Documentation by Responsibility

### Decision

Organize project documentation into focused documents rather than a single large design document.

### Rationale

Separating architecture, deployment, validation, lessons learned, and design decisions makes the documentation easier to maintain and aligns with the future publishing workflow planned for Cloud Architect Lab and CAL CLI.

---

## Future Decisions

As the project evolves, additional architectural decisions may include:

- CIDR allocation strategy
- Multi-AZ design
- NAT Gateway placement
- Network ACL usage
- Route table organization
- High availability considerations
- Cost optimization decisions

Significant long-term decisions should also be documented as individual Architecture Decision Records (ADRs) when appropriate.

## Decision 6 — Separate Security Groups by Application Tier

### Decision

Create separate Security Groups for the public web tier and the private application tier.

### Rationale

Separating Security Groups follows the principle of least privilege by assigning different network access policies to different application tiers. Public-facing resources require different access than private application resources, and separating them improves security, readability, and long-term maintainability.

---

## Decision 7 — Use Security Group References Between Application Tiers

### Decision

Allow communication from the public web tier to the private application tier by referencing the public web Security Group instead of allowing traffic from IP addresses or subnet CIDR ranges.

### Rationale

Security Group references express trust between application tiers rather than network locations. This approach is resilient to infrastructure changes because resources may be replaced or scaled without requiring updates to IP-based firewall rules. It reflects a cloud-native security model commonly used in AWS environments.

---

## Decision 8 — Use TCP Port 8080 for the Private Application Tier

### Decision

Model communication between the public web tier and the private application tier using TCP port 8080.

### Rationale

Port 8080 is commonly used by enterprise application servers such as Apache Tomcat, Spring Boot, and other Java-based web applications. Although this project does not yet deploy an application, using a realistic application port demonstrates a common multi-tier architecture pattern while remaining independent of any specific application framework.

---
