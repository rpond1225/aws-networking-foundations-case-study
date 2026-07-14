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

## Decision 4 — Build the Network in Incremental Milestones

### Decision

Implement the networking architecture through small, validated milestones rather than deploying a complete production-style environment in a single iteration.

### Rationale

Incremental implementation allows each networking concept to be designed, implemented, validated, documented, and committed independently.

This approach keeps the architecture aligned with the deployed infrastructure while reducing complexity during development. It also produces clearer documentation by allowing each milestone to focus on a single architectural concept before introducing the next.

---

## Decision 5 — Separate Repository Documentation by Responsibility

### Decision

Organize project documentation into focused documents rather than a single large design document.

### Rationale

Separating architecture, deployment, validation, lessons learned, and design decisions makes the documentation easier to maintain and aligns with the future publishing workflow planned for Cloud Architect Lab and CAL CLI.

---

## Architecture Decision Records (ADRs)

As the project evolves, significant implementation and architecture decisions may be captured as individual ADRs within the `docs/adr/` directory.

Current ADRs include:

- ADR-001 — Structured Availability Zone Configuration with `for_each`

Future ADRs may document decisions such as:

- CIDR allocation strategy
- Multi-AZ design
- NAT Gateway placement
- Network ACL usage
- Route table organization
- High availability considerations
- Cost optimization
- Module organization

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

## Decision 9 — Keep Documentation Aligned with Deployed Infrastructure

### Decision

Architecture diagrams and documentation will always represent the current Terraform-managed infrastructure unless explicitly marked as a proposed or target architecture.

## Decision 10 — Use Default Network ACLs for the Initial Implementation

### Decision

Retain the AWS default Network ACLs for the initial networking foundation and rely on Security Groups as the primary traffic control mechanism.

### Rationale

The objectives of CAL-001 are to establish foundational networking concepts, demonstrate Infrastructure as Code, and implement clear network segmentation. Security Groups provide stateful, resource-level access control that satisfies the requirements of this case study while keeping the design simple and maintainable.

Introducing custom Network ACLs at this stage would increase configuration complexity without materially improving the security posture of the deployed architecture. In environments with stricter compliance, regulatory requirements, or advanced segmentation needs, custom Network ACLs can provide an additional layer of subnet-level control as part of a defense-in-depth strategy. Those scenarios are intentionally deferred to future case studies where their benefits can be demonstrated in context.

### Rationale

Keeping documentation synchronized with deployed infrastructure prevents confusion between implemented and planned capabilities.

Future architectural designs may be documented separately as proposed architecture, but the primary project documentation should accurately reflect the current implementation.

This approach reinforces Infrastructure as Code and Architecture as Code by ensuring diagrams, documentation, and Terraform evolve together.

---
